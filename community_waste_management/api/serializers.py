from rest_framework import serializers
from apps.users.models import User, House
from apps.points.models import WastePoint, Sensor
from apps.waste_records.models import WasteCategory, WasteRecord, PointTransaction
from apps.products.models import Product, Order
from apps.guides.models import GuideCategory, GuideItem, FAQ
from apps.activities.models import Activity, ActivityParticipant, Notification
from apps.feedback.models import Feedback, PointEvaluation, ViolationReport

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'
        extra_kwargs = {
            'password': {'write_only': True},
            'username': {
                'error_messages': {
                    'required': '用户名不能为空',
                    'blank': '用户名不能为空白',
                    'max_length': '用户名过长，最多150个字符',
                    'unique': '该用户名已被注册，请使用其他用户名'
                }
            },
            'email': {
                'error_messages': {
                    'required': '邮箱不能为空',
                    'blank': '邮箱不能为空白',
                    'invalid': '请输入有效的邮箱地址',
                    'unique': '该邮箱已被注册，请使用其他邮箱'
                }
            },
            'phone_number': {
                'error_messages': {
                    'invalid': '手机号格式不正确'
                }
            },
            'role': {
                'error_messages': {
                    'required': '请选择用户身份',
                    'invalid_choice': '无效的用户身份选择'
                }
            }
        }

    def validate_username(self, value):
        if not value or not value.strip():
            raise serializers.ValidationError('用户名不能为空')
        if len(value.strip()) < 2:
            raise serializers.ValidationError('用户名至少需要2个字符')
        if len(value) > 150:
            raise serializers.ValidationError('用户名不能超过150个字符')
        return value.strip()

    def validate_phone_number(self, value):
        import re
        if value:
            phone_pattern = r'^1[3-9]\d{9}$'
            if not re.match(phone_pattern, value):
                raise serializers.ValidationError('手机号格式不正确，请输入11位有效手机号')
        return value

    def validate_email(self, value):
        if not value or not value.strip():
            raise serializers.ValidationError('邮箱不能为空')
        email_regex = r'^[^\s@]+@[^\s@]+\.[^\s@]+$'
        import re
        if not re.match(email_regex, value):
            raise serializers.ValidationError('请输入有效的邮箱地址')
        return value.strip().lower()

    def validate_password(self, value):
        if not value:
            raise serializers.ValidationError('密码不能为空')
        if len(value) < 6:
            raise serializers.ValidationError('密码至少需要6个字符')
        return value

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user

class HouseSerializer(serializers.ModelSerializer):
    class Meta:
        model = House
        fields = '__all__'

class WastePointSerializer(serializers.ModelSerializer):
    class Meta:
        model = WastePoint
        fields = '__all__'

class SensorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sensor
        fields = '__all__'

class WasteCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = WasteCategory
        fields = '__all__'

class WasteRecordSerializer(serializers.ModelSerializer):
    class Meta:
        model = WasteRecord
        fields = '__all__'
        read_only_fields = ['user', 'points_earned', 'created_at']

class PointTransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = PointTransaction
        fields = '__all__'

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'

class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'

class GuideCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = GuideCategory
        fields = '__all__'

class GuideItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = GuideItem
        fields = '__all__'

class FAQSerializer(serializers.ModelSerializer):
    class Meta:
        model = FAQ
        fields = '__all__'

class ActivitySerializer(serializers.ModelSerializer):
    class Meta:
        model = Activity
        fields = '__all__'

class ActivityParticipantSerializer(serializers.ModelSerializer):
    class Meta:
        model = ActivityParticipant
        fields = '__all__'

class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = '__all__'

class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = Feedback
        fields = '__all__'

class PointEvaluationSerializer(serializers.ModelSerializer):
    class Meta:
        model = PointEvaluation
        fields = '__all__'

class ViolationReportSerializer(serializers.ModelSerializer):
    class Meta:
        model = ViolationReport
        fields = '__all__'