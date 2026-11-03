from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenRefreshView
from api.views_optimized import (
    # 认证
    AuthViewSet,
    # 用户管理
    UserViewSet, HouseViewSet,
    # 投放点管理
    WastePointViewSet, SensorViewSet,
    # 垃圾分类记录
    WasteCategoryViewSet, WasteRecordViewSet, PointTransactionViewSet,
    # 积分商城
    ProductViewSet, OrderViewSet,
    # 分类指南
    GuideCategoryViewSet, GuideItemViewSet, FAQViewSet,
    # 活动管理
    ActivityViewSet, ActivityParticipantViewSet, NotificationViewSet,
    # 反馈管理
    FeedbackViewSet, PointEvaluationViewSet, ViolationReportViewSet,
    # 报告和分析
    ReportViewSet,
    # 数据备份
    BackupViewSet,
    # 智能推荐
    RecommendationViewSet,
)

# 创建路由器
router = DefaultRouter()

# 认证相关
router.register(r'auth', AuthViewSet, basename='auth')

# 用户管理
router.register(r'users', UserViewSet, basename='user')
router.register(r'houses', HouseViewSet, basename='house')

# 投放点管理
router.register(r'waste-points', WastePointViewSet, basename='waste-point')
router.register(r'sensors', SensorViewSet, basename='sensor')

# 垃圾分类记录
router.register(r'waste-categories', WasteCategoryViewSet, basename='waste-category')
router.register(r'waste-records', WasteRecordViewSet, basename='waste-record')
router.register(r'point-transactions', PointTransactionViewSet, basename='point-transaction')

# 积分商城
router.register(r'products', ProductViewSet, basename='product')
router.register(r'orders', OrderViewSet, basename='order')

# 分类指南
router.register(r'guide-categories', GuideCategoryViewSet, basename='guide-category')
router.register(r'guide-items', GuideItemViewSet, basename='guide-item')
router.register(r'faqs', FAQViewSet, basename='faq')

# 活动管理
router.register(r'activities', ActivityViewSet, basename='activity')
router.register(r'activity-participants', ActivityParticipantViewSet, basename='activity-participant')
router.register(r'notifications', NotificationViewSet, basename='notification')

# 反馈管理
router.register(r'feedbacks', FeedbackViewSet, basename='feedback')
router.register(r'point-evaluations', PointEvaluationViewSet, basename='point-evaluation')
router.register(r'violation-reports', ViolationReportViewSet, basename='violation-report')

# 报告和分析
router.register(r'reports', ReportViewSet, basename='report')

# 数据备份
router.register(r'backups', BackupViewSet, basename='backup')

# 智能推荐
router.register(r'recommendations', RecommendationViewSet, basename='recommendation')

# URL 配置
urlpatterns = [
    path('', include(router.urls)),
    # JWT Token 刷新
    path('token/refresh/', TokenRefreshView.as_view(), name='token-refresh'),
]
