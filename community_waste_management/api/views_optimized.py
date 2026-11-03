"""
社区垃圾分类管理系统 - 优化后的 API 视图
使用 Django REST Framework 构建现代化 API
"""

import datetime
import re
import random
from decimal import Decimal
from django.db.models import Sum, Count, Avg, Q, F
from django.db.models.functions import TruncDate
from django.utils import timezone
from rest_framework import viewsets, status, permissions
from rest_framework.decorators import action, api_view, permission_classes
from rest_framework.response import Response
from rest_framework.views import APIView
from django.contrib.auth import authenticate
from rest_framework_simplejwt.tokens import RefreshToken
from django.shortcuts import get_object_or_404

from apps.users.models import User, House
from apps.points.models import WastePoint, Sensor
from apps.waste_records.models import WasteCategory, WasteRecord, PointTransaction
from apps.products.models import Product, Order
from apps.guides.models import GuideCategory, GuideItem, FAQ
from apps.activities.models import Activity, ActivityParticipant, Notification
from apps.feedback.models import Feedback, PointEvaluation, ViolationReport

from api.serializers import (
    UserSerializer, HouseSerializer, WastePointSerializer, SensorSerializer,
    WasteCategorySerializer, WasteRecordSerializer, PointTransactionSerializer,
    ProductSerializer, OrderSerializer, GuideCategorySerializer, GuideItemSerializer, FAQSerializer,
    ActivitySerializer, ActivityParticipantSerializer, NotificationSerializer,
    FeedbackSerializer, PointEvaluationSerializer, ViolationReportSerializer
)


# ==================== 工具函数 ====================

def get_user_level(points):
    """根据积分获取用户等级"""
    if points < 100:
        return '新手'
    elif points < 500:
        return '达人'
    else:
        return '模范'


def calculate_points(weight, is_qualified=True):
    """计算投放积分"""
    base_points = int(weight * 10)  # 每公斤10积分
    if is_qualified:
        return base_points
    return base_points // 2  # 不合格减半


def validate_phone(phone):
    """验证手机号格式"""
    pattern = r'^1[3-9]\d{9}$'
    return re.match(pattern, phone) is not None


# ==================== 认证相关 API ====================

class AuthViewSet(viewsets.ViewSet):
    """认证相关 API"""
    permission_classes = [permissions.AllowAny]
    
    @action(detail=False, methods=['post'])
    def login(self, request):
        """用户登录"""
        username = request.data.get('username')
        password = request.data.get('password')
        
        if not username or not password:
            return Response({'error': '用户名和密码不能为空'}, status=status.HTTP_400_BAD_REQUEST)
        
        user = authenticate(username=username, password=password)
        if user:
            refresh = RefreshToken.for_user(user)
            return Response({
                'refresh': str(refresh),
                'access': str(refresh.access_token),
                'user': UserSerializer(user).data
            })
        return Response({'error': '用户名或密码错误'}, status=status.HTTP_401_UNAUTHORIZED)
    
    @action(detail=False, methods=['post'])
    def register(self, request):
        """用户注册"""
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            refresh = RefreshToken.for_user(user)
            return Response({
                'refresh': str(refresh),
                'access': str(refresh.access_token),
                'user': UserSerializer(user).data
            }, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    @action(detail=False, methods=['post'])
    def logout(self, request):
        """用户退出"""
        try:
            refresh_token = request.data.get('refresh')
            token = RefreshToken(refresh_token)
            token.blacklist()
            return Response({'message': '退出成功'})
        except Exception:
            return Response({'error': '退出失败'}, status=status.HTTP_400_BAD_REQUEST)


# ==================== 用户管理 API ====================

class UserViewSet(viewsets.ModelViewSet):
    """
    居民用户管理 API
    功能：创建、修改、停用和注销居民账号，关联房屋信息，监控投放行为日志，角色权限管理
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer
    
    def get_permissions(self):
        if self.action in ['create', 'register']:
            return [permissions.AllowAny()]
        return [permissions.IsAuthenticated()]
    
    @action(detail=False, methods=['get'])
    def me(self, request):
        """获取当前用户信息"""
        serializer = self.get_serializer(request.user)
        return Response(serializer.data)
    
    @action(detail=False, methods=['post'])
    def change_password(self, request):
        """修改密码"""
        user = request.user
        old_password = request.data.get('old_password')
        new_password = request.data.get('new_password')
        
        if not user.check_password(old_password):
            return Response({'error': '原密码错误'}, status=status.HTTP_400_BAD_REQUEST)
        
        user.set_password(new_password)
        user.save()
        return Response({'message': '密码修改成功'})
    
    @action(detail=True, methods=['post'])
    def deactivate(self, request, pk=None):
        """停用账号"""
        user = self.get_object()
        user.is_active = False
        user.save()
        return Response({'message': '账号已停用'})
    
    @action(detail=True, methods=['post'])
    def activate(self, request, pk=None):
        """激活账号"""
        user = self.get_object()
        user.is_active = True
        user.save()
        return Response({'message': '账号已激活'})
    
    @action(detail=True, methods=['get'])
    def behavior_log(self, request, pk=None):
        """获取用户投放行为日志"""
        user = self.get_object()
        records = WasteRecord.objects.filter(user=user).order_by('-created_at')
        serializer = WasteRecordSerializer(records, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def leaderboard(self, request):
        """居民积分排行榜"""
        users = User.objects.filter(role='resident').order_by('-points')[:50]
        serializer = self.get_serializer(users, many=True)
        return Response(serializer.data)


class HouseViewSet(viewsets.ModelViewSet):
    """房屋信息管理 API"""
    queryset = House.objects.all()
    serializer_class = HouseSerializer
    permission_classes = [permissions.IsAuthenticated]
    
    def get_queryset(self):
        """只返回当前用户的房屋信息"""
        return House.objects.filter(user=self.request.user)


# ==================== 投放点管理 API ====================

class WastePointViewSet(viewsets.ModelViewSet):
    """
    智能投放点管理 API
    功能：维护投放点信息、监控满溢状态、管理清运计划、更新设备状态
    """
    permission_classes = [permissions.AllowAny]
    queryset = WastePoint.objects.all()
    serializer_class = WastePointSerializer
    
    @action(detail=True, methods=['post'])
    def update_status(self, request, pk=None):
        """更新投放点状态（满溢状态）"""
        point = self.get_object()
        fill_level = request.data.get('fill_level', 0)
        
        point.fill_level = fill_level
        if fill_level >= 90:
            point.status = 'full'
        elif fill_level >= 70:
            point.status = 'warning'
        else:
            point.status = 'normal'
        point.save()
        
        # 如果满溢，发送通知
        if fill_level >= 90:
            Notification.objects.create(
                user=request.user,
                title='投放点满溢提醒',
                content=f'投放点 {point.name} 已满，请及时清运',
                notification_type='warning'
            )
        
        return Response({'message': '状态更新成功', 'status': point.status})
    
    @action(detail=True, methods=['post'])
    def schedule_cleanup(self, request, pk=None):
        """创建清运计划"""
        point = self.get_object()
        cleanup_time = request.data.get('cleanup_time')
        
        # 这里可以添加与物业系统的同步逻辑
        point.next_cleanup = cleanup_time
        point.save()
        
        return Response({'message': '清运计划已创建'})
    
    @action(detail=False, methods=['get'])
    def monitor(self, request):
        """实时监控所有投放点状态"""
        points = WastePoint.objects.all()
        data = {
            'total': points.count(),
            'normal': points.filter(status='normal').count(),
            'warning': points.filter(status='warning').count(),
            'full': points.filter(status='full').count(),
            'offline': points.filter(status='offline').count(),
            'points': WastePointSerializer(points, many=True).data
        }
        return Response(data)
    
    @action(detail=False, methods=['get'])
    def nearby(self, request):
        """查找附近的投放点"""
        lat = request.query_params.get('lat')
        lng = request.query_params.get('lng')
        category = request.query_params.get('category')
        
        points = WastePoint.objects.all()
        if category:
            points = points.filter(accepted_categories__contains=category)
        
        # 这里可以添加基于地理位置的排序逻辑
        serializer = self.get_serializer(points, many=True)
        return Response(serializer.data)


class SensorViewSet(viewsets.ModelViewSet):
    """传感器管理 API"""
    permission_classes = [permissions.AllowAny]
    queryset = Sensor.objects.all()
    serializer_class = SensorSerializer
    
    @action(detail=True, methods=['post'])
    def report_data(self, request, pk=None):
        """传感器上报数据"""
        sensor = self.get_object()
        fill_level = request.data.get('fill_level')
        temperature = request.data.get('temperature')
        
        sensor.fill_level = fill_level
        sensor.temperature = temperature
        sensor.last_reading = timezone.now()
        sensor.save()
        
        # 同步更新投放点状态
        point = sensor.waste_point
        point.fill_level = fill_level
        point.save()
        
        return Response({'message': '数据上报成功'})


# ==================== 垃圾分类记录 API ====================

class WasteCategoryViewSet(viewsets.ModelViewSet):
    """垃圾分类类别管理 API"""
    permission_classes = [permissions.AllowAny]
    queryset = WasteCategory.objects.all()
    serializer_class = WasteCategorySerializer
    
    @action(detail=False, methods=['get'])
    def search(self, request):
        """搜索垃圾类别"""
        keyword = request.query_params.get('keyword', '')
        categories = WasteCategory.objects.filter(
            Q(name__icontains=keyword) | Q(description__icontains=keyword)
        )
        serializer = self.get_serializer(categories, many=True)
        return Response(serializer.data)


class WasteRecordViewSet(viewsets.ModelViewSet):
    """
    投放记录与积分结算 API
    功能：记录投放信息、计算积分、支持扫码/人脸识别
    """
    permission_classes = [permissions.IsAuthenticated]
    queryset = WasteRecord.objects.all()
    serializer_class = WasteRecordSerializer

    def get_queryset(self):
        """返回当前用户的投放记录"""
        return WasteRecord.objects.filter(user=self.request.user)

    def get_permissions(self):
        """获取权限：列表和详情允许查看，创建需要登录"""
        if self.action in ['list', 'retrieve']:
            return [permissions.AllowAny()]
        return [permissions.IsAuthenticated()]

    def perform_create(self, serializer):
        """创建投放记录时自动计算积分"""
        user = self.request.user

        if not user.is_authenticated:
            raise serializers.ValidationError("请先登录后再进行投放")

        weight = serializer.validated_data.get('weight', 0)
        is_qualified = serializer.validated_data.get('is_qualified', True)

        points = calculate_points(weight, is_qualified)

        record = serializer.save(user=user, points_earned=points)

        user.points += points
        user.level = get_user_level(user.points)
        user.save()

        PointTransaction.objects.create(
            user=user,
            transaction_type='earn',
            points=points,
            description=f'投放{record.category.name}获得积分',
            related_record=record
        )

        point = record.waste_point
        point.current_fill += weight
        if point.capacity > 0 and point.current_fill >= point.capacity * 0.9:
            point.status = 'full'
        point.save()
    
    @action(detail=False, methods=['get'])
    def summary(self, request):
        """获取投放统计摘要"""
        user = request.user
        records = WasteRecord.objects.filter(user=user)
        
        # 本月统计
        this_month = timezone.now().replace(day=1)
        month_records = records.filter(created_at__gte=this_month)
        
        data = {
            'total_count': records.count(),
            'total_weight': records.aggregate(Sum('weight'))['weight__sum'] or 0,
            'total_points': records.aggregate(Sum('points_earned'))['points_earned__sum'] or 0,
            'month_count': month_records.count(),
            'month_weight': month_records.aggregate(Sum('weight'))['weight__sum'] or 0,
            'by_category': records.values('category__name').annotate(
                count=Count('id'),
                weight=Sum('weight')
            )
        }
        return Response(data)
    
    @action(detail=False, methods=['post'])
    def scan_record(self, request):
        """扫码记录投放"""
        qr_code = request.data.get('qr_code')
        # 解析二维码获取投放点信息
        # 这里可以实现具体的二维码解析逻辑
        return Response({'message': '扫码记录成功'})


class PointTransactionViewSet(viewsets.ModelViewSet):
    """积分交易记录 API"""
    queryset = PointTransaction.objects.all()
    serializer_class = PointTransactionSerializer
    permission_classes = [permissions.IsAuthenticated]
    
    def get_queryset(self):
        return PointTransaction.objects.filter(user=self.request.user)


# ==================== 积分商城 API ====================

class ProductViewSet(viewsets.ModelViewSet):
    """
    积分商品管理 API
    功能：商品库存管理、积分兑换
    """
    permission_classes = [permissions.AllowAny]
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    
    @action(detail=False, methods=['get'])
    def available(self, request):
        """获取可兑换的商品"""
        products = Product.objects.filter(stock__gt=0)
        serializer = self.get_serializer(products, many=True)
        return Response(serializer.data)
    
    @action(detail=True, methods=['post'])
    def exchange(self, request, pk=None):
        """兑换商品"""
        product = self.get_object()
        user = request.user
        quantity = request.data.get('quantity', 1)
        
        # 检查库存
        if product.stock < quantity:
            return Response({'error': '商品库存不足'}, status=status.HTTP_400_BAD_REQUEST)
        
        # 检查积分
        total_cost = product.points_required * quantity
        if user.points < total_cost:
            return Response({'error': '积分不足'}, status=status.HTTP_400_BAD_REQUEST)
        
        # 创建订单
        order = Order.objects.create(
            user=user,
            product=product,
            quantity=quantity,
            total_points=total_cost,
            status='pending'
        )
        
        # 扣除积分
        user.points -= total_cost
        user.save()
        
        # 减少库存
        product.stock -= quantity
        product.save()
        
        # 创建积分交易记录
        PointTransaction.objects.create(
            user=user,
            transaction_type='spend',
            points=-total_cost,
            description=f'兑换{product.name}'
        )
        
        return Response({
            'message': '兑换成功',
            'order': OrderSerializer(order).data
        })
    
    @action(detail=True, methods=['post'])
    def restock(self, request, pk=None):
        """补充库存（管理员功能）"""
        product = self.get_object()
        amount = request.data.get('amount', 0)
        
        product.stock += amount
        product.save()
        
        return Response({
            'message': '库存补充成功',
            'current_stock': product.stock
        })


class OrderViewSet(viewsets.ModelViewSet):
    """订单管理 API"""
    permission_classes = [permissions.AllowAny]
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

    def get_queryset(self):
        return Order.objects.all()
    
    @action(detail=True, methods=['post'])
    def pickup(self, request, pk=None):
        """领取商品"""
        order = self.get_object()
        order.status = 'completed'
        order.save()
        return Response({'message': '领取成功'})


# ==================== 分类指南 API ====================

class GuideCategoryViewSet(viewsets.ModelViewSet):
    """指南分类管理 API"""
    permission_classes = [permissions.AllowAny]
    queryset = GuideCategory.objects.all()
    serializer_class = GuideCategorySerializer


class GuideItemViewSet(viewsets.ModelViewSet):
    """
    分类指南管理 API
    功能：维护指南内容、支持搜索、按类别筛选
    """
    permission_classes = [permissions.AllowAny]
    queryset = GuideItem.objects.all()
    serializer_class = GuideItemSerializer
    
    @action(detail=False, methods=['get'])
    def search(self, request):
        """搜索指南"""
        keyword = request.query_params.get('keyword', '')
        items = GuideItem.objects.filter(
            Q(title__icontains=keyword) | Q(content__icontains=keyword)
        )
        serializer = self.get_serializer(items, many=True)
        return Response(serializer.data)


class FAQViewSet(viewsets.ModelViewSet):
    """常见问题管理 API"""
    permission_classes = [permissions.AllowAny]
    queryset = FAQ.objects.all()
    serializer_class = FAQSerializer
    
    @action(detail=False, methods=['get'])
    def search(self, request):
        """智能搜索FAQ"""
        keyword = request.query_params.get('keyword', '')
        faqs = FAQ.objects.filter(
            Q(question__icontains=keyword) | Q(answer__icontains=keyword)
        )
        serializer = self.get_serializer(faqs, many=True)
        return Response(serializer.data)


# ==================== 活动管理 API ====================

class ActivityViewSet(viewsets.ModelViewSet):
    """
    积分激励与活动管理 API
    功能：创建激励活动、统计参与率
    """
    permission_classes = [permissions.AllowAny]
    queryset = Activity.objects.all()
    serializer_class = ActivitySerializer
    
    @action(detail=True, methods=['post'])
    def join(self, request, pk=None):
        """参与活动"""
        activity = self.get_object()
        user = request.user
        
        # 检查是否已参与
        if ActivityParticipant.objects.filter(activity=activity, user=user).exists():
            return Response({'error': '已参与该活动'}, status=status.HTTP_400_BAD_REQUEST)
        
        # 创建参与记录
        participant = ActivityParticipant.objects.create(
            activity=activity,
            user=user
        )
        
        # 发放活动奖励积分
        if activity.reward_points > 0:
            user.points += activity.reward_points
            user.save()
            
            PointTransaction.objects.create(
                user=user,
                transaction_type='earn',
                points=activity.reward_points,
                description=f'参与活动{activity.title}获得奖励'
            )
        
        return Response({'message': '参与成功'})
    
    @action(detail=True, methods=['get'])
    def statistics(self, request, pk=None):
        """活动统计"""
        activity = self.get_object()
        participants = ActivityParticipant.objects.filter(activity=activity)
        
        data = {
            'total_participants': participants.count(),
            'participation_rate': self._calculate_participation_rate(activity),
            'by_building': participants.values('user__houses__building').annotate(
                count=Count('id')
            )
        }
        return Response(data)
    
    def _calculate_participation_rate(self, activity):
        """计算活动参与率"""
        total_users = User.objects.filter(role='resident').count()
        participants = ActivityParticipant.objects.filter(activity=activity).count()
        if total_users == 0:
            return 0
        return (participants / total_users) * 100


class ActivityParticipantViewSet(viewsets.ModelViewSet):
    """活动参与者管理 API"""
    queryset = ActivityParticipant.objects.all()
    serializer_class = ActivityParticipantSerializer
    permission_classes = [permissions.IsAuthenticated]


class NotificationViewSet(viewsets.ModelViewSet):
    """通知管理 API"""
    queryset = Notification.objects.all()
    serializer_class = NotificationSerializer
    permission_classes = [permissions.IsAuthenticated]
    
    def get_queryset(self):
        return Notification.objects.filter(user=self.request.user)
    
    @action(detail=False, methods=['get'])
    def unread(self, request):
        """获取未读通知"""
        notifications = Notification.objects.filter(
            user=request.user,
            is_read=False
        )
        serializer = self.get_serializer(notifications, many=True)
        return Response(serializer.data)
    
    @action(detail=True, methods=['post'])
    def mark_read(self, request, pk=None):
        """标记为已读"""
        notification = self.get_object()
        notification.is_read = True
        notification.save()
        return Response({'message': '已标记为已读'})


# ==================== 反馈管理 API ====================

class FeedbackViewSet(viewsets.ModelViewSet):
    """居民反馈 API"""
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer
    permission_classes = [permissions.IsAuthenticated]
    
    def get_queryset(self):
        return Feedback.objects.filter(user=self.request.user)
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class PointEvaluationViewSet(viewsets.ModelViewSet):
    """投放点评价 API"""
    queryset = PointEvaluation.objects.all()
    serializer_class = PointEvaluationSerializer
    permission_classes = [permissions.IsAuthenticated]
    
    def get_queryset(self):
        return PointEvaluation.objects.filter(user=self.request.user)
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class ViolationReportViewSet(viewsets.ModelViewSet):
    """违规投放举报 API"""
    queryset = ViolationReport.objects.all()
    serializer_class = ViolationReportSerializer
    permission_classes = [permissions.IsAuthenticated]
    
    def get_queryset(self):
        return ViolationReport.objects.filter(reporter=self.request.user)
    
    def perform_create(self, serializer):
        serializer.save(reporter=self.request.user)


# ==================== 报告和分析 API ====================

class ReportViewSet(viewsets.ViewSet):
    """
    报告和分析工具 API
    功能：生成实时和历史数据报告、可视化图表
    """
    permission_classes = [permissions.IsAuthenticated]
    
    @action(detail=False, methods=['get'])
    def dashboard(self, request):
        """管理仪表盘数据"""
        today = timezone.now().date()
        
        # 今日投放统计
        today_records = WasteRecord.objects.filter(created_at__date=today)
        
        # 分类正确率
        total_records = today_records.count()
        qualified_records = today_records.filter(is_qualified=True).count()
        accuracy_rate = (qualified_records / total_records * 100) if total_records > 0 else 0
        
        # 投放点满溢频率
        full_points = WastePoint.objects.filter(status='full').count()
        
        # 积分排行榜
        top_users = User.objects.filter(role='resident').order_by('-points')[:10]
        
        data = {
            'today': {
                'total_weight': today_records.aggregate(Sum('weight'))['weight__sum'] or 0,
                'total_count': today_records.count(),
                'accuracy_rate': round(accuracy_rate, 2),
            },
            'points_status': {
                'full_count': full_points,
                'warning_count': WastePoint.objects.filter(status='warning').count(),
                'normal_count': WastePoint.objects.filter(status='normal').count(),
            },
            'leaderboard': UserSerializer(top_users, many=True).data,
            'monthly_trend': self._get_monthly_trend(),
        }
        return Response(data)
    
    @action(detail=False, methods=['get'])
    def waste_statistics(self, request):
        """垃圾分类统计报告"""
        start_date = request.query_params.get('start_date')
        end_date = request.query_params.get('end_date')
        
        records = WasteRecord.objects.all()
        if start_date:
            records = records.filter(created_at__date__gte=start_date)
        if end_date:
            records = records.filter(created_at__date__lte=end_date)
        
        data = {
            'by_category': records.values('category__name').annotate(
                count=Count('id'),
                weight=Sum('weight'),
                points=Sum('points_earned')
            ),
            'by_date': records.annotate(
                date=TruncDate('created_at')
            ).values('date').annotate(
                count=Count('id'),
                weight=Sum('weight')
            ).order_by('date'),
            'by_point': records.values('waste_point__name').annotate(
                count=Count('id'),
                weight=Sum('weight')
            ),
        }
        return Response(data)
    
    @action(detail=False, methods=['get'])
    def user_analysis(self, request):
        """用户行为分析"""
        # 活跃度分析
        active_users = WasteRecord.objects.values('user').annotate(
            count=Count('id')
        ).order_by('-count')[:20]
        
        # 低参与度楼栋
        low_participation = House.objects.values('building').annotate(
            user_count=Count('user'),
            record_count=Count('user__wasterecord')
        ).filter(record_count__lt=5)
        
        data = {
            'active_users': active_users,
            'low_participation_buildings': low_participation,
            'total_users': User.objects.filter(role='resident').count(),
            'active_today': WasteRecord.objects.filter(
                created_at__date=timezone.now().date()
            ).values('user').distinct().count(),
        }
        return Response(data)
    
    def _get_monthly_trend(self):
        """获取月度趋势"""
        from django.db.models.functions import TruncMonth
        
        return WasteRecord.objects.annotate(
            month=TruncMonth('created_at')
        ).values('month').annotate(
            count=Count('id'),
            weight=Sum('weight')
        ).order_by('month')[:12]


# ==================== 数据备份 API ====================

class BackupViewSet(viewsets.ViewSet):
    """
    数据备份和恢复 API
    """
    permission_classes = [permissions.IsAdminUser]
    
    @action(detail=False, methods=['post'])
    def backup(self, request):
        """创建数据备份"""
        # 这里可以实现具体的数据库备份逻辑
        # 可以使用 Django 的 dumpdata 命令或自定义备份逻辑
        import subprocess
        from django.conf import settings
        
        timestamp = timezone.now().strftime('%Y%m%d_%H%M%S')
        backup_file = f'backup_{timestamp}.json'
        
        try:
            subprocess.run(
                ['python', 'manage.py', 'dumpdata', '--output', f'backups/{backup_file}'],
                check=True
            )
            return Response({
                'message': '备份成功',
                'file': backup_file
            })
        except subprocess.CalledProcessError as e:
            return Response({'error': f'备份失败: {str(e)}'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    @action(detail=False, methods=['post'])
    def restore(self, request):
        """恢复数据"""
        backup_file = request.data.get('backup_file')
        
        if not backup_file:
            return Response({'error': '请指定备份文件'}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
            import subprocess
            subprocess.run(
                ['python', 'manage.py', 'loaddata', f'backups/{backup_file}'],
                check=True
            )
            return Response({'message': '恢复成功'})
        except subprocess.CalledProcessError as e:
            return Response({'error': f'恢复失败: {str(e)}'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


# ==================== 智能推荐 API ====================

class RecommendationViewSet(viewsets.ViewSet):
    """
    个性化推荐系统 API
    """
    permission_classes = [permissions.IsAuthenticated]
    
    @action(detail=False, methods=['get'])
    def tips(self, request):
        """根据用户历史投放记录推荐分类技巧"""
        user = request.user
        
        # 获取用户最常投放的垃圾类别
        top_categories = WasteRecord.objects.filter(user=user).values(
            'category__name'
        ).annotate(count=Count('id')).order_by('-count')[:3]
        
        tips = []
        for cat in top_categories:
            category_name = cat['category__name']
            if '厨余' in category_name:
                tips.append({
                    'category': category_name,
                    'tip': '厨余垃圾减量小窍门：剩菜剩饭沥干水分后再投放，可以减少异味和重量',
                    'type': 'reduction'
                })
            elif '可回收' in category_name:
                tips.append({
                    'category': category_name,
                    'tip': '可回收物请保持清洁干燥，压扁后投放可以节省空间',
                    'type': 'recycling'
                })
            elif '有害' in category_name:
                tips.append({
                    'category': category_name,
                    'tip': '有害垃圾请轻放，避免破损造成污染',
                    'type': 'safety'
                })
        
        return Response(tips)
    
    @action(detail=False, methods=['get'])
    def nearby_points(self, request):
        """推荐附近空闲的投放点"""
        category = request.query_params.get('category')
        
        # 获取状态正常的投放点
        points = WastePoint.objects.filter(
            status__in=['normal', 'warning']
        ).order_by('fill_level')
        
        if category:
            points = points.filter(accepted_categories__contains=category)
        
        serializer = WastePointSerializer(points[:5], many=True)
        return Response(serializer.data)
