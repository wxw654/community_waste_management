from django.db import models
from apps.users.models import User
from apps.points.models import WastePoint

class Feedback(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='feedbacks')
    title = models.CharField(max_length=100)
    content = models.TextField()
    image_url = models.CharField(max_length=200, blank=True, null=True)
    status = models.CharField(max_length=20, choices=[('pending', '待处理'), ('processed', '已处理'), ('closed', '已关闭')])
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title

class PointEvaluation(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='point_evaluations')
    waste_point = models.ForeignKey(WastePoint, on_delete=models.CASCADE, related_name='evaluations')
    cleanliness = models.IntegerField(default=5)
    equipment_status = models.IntegerField(default=5)
    comment = models.TextField(blank=True, null=True)
    image_url = models.CharField(max_length=200, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.waste_point.name}"

class ViolationReport(models.Model):
    reporter = models.ForeignKey(User, on_delete=models.CASCADE, related_name='violation_reports', blank=True, null=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='reported_violations', blank=True, null=True)
    waste_point = models.ForeignKey(WastePoint, on_delete=models.CASCADE, related_name='violation_reports')
    description = models.TextField()
    image_url = models.CharField(max_length=200, blank=True, null=True)
    status = models.CharField(max_length=20, choices=[('pending', '待审核'), ('confirmed', '已确认'), ('rejected', '已驳回')])
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
