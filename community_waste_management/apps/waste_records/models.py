from django.db import models
from apps.users.models import User
from apps.points.models import WastePoint

class WasteCategory(models.Model):
    name = models.CharField(max_length=50)
    description = models.TextField(blank=True, null=True)
    point_value = models.IntegerField(default=1)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class WasteRecord(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='waste_records')
    waste_point = models.ForeignKey(WastePoint, on_delete=models.CASCADE, related_name='waste_records')
    category = models.ForeignKey(WasteCategory, on_delete=models.CASCADE, related_name='waste_records')
    weight = models.FloatField()
    points_earned = models.IntegerField()
    is_qualified = models.BooleanField(default=True)
    image_url = models.CharField(max_length=200, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.category.name} - {self.created_at}"

class PointTransaction(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='point_transactions')
    points = models.IntegerField(default=0)
    transaction_type = models.CharField(max_length=20, choices=[('earn', '获得'), ('spend', '消费')], default='earn')
    description = models.CharField(max_length=200)
    related_record = models.ForeignKey(WasteRecord, on_delete=models.SET_NULL, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
