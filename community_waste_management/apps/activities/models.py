from django.db import models
from apps.users.models import User

class Activity(models.Model):
    title = models.CharField(max_length=100, default='无标题')
    name = models.CharField(max_length=100, blank=True, null=True)
    description = models.TextField()
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    reward_points = models.IntegerField(default=0)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title or self.name

class ActivityParticipant(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='activity_participants')
    activity = models.ForeignKey(Activity, on_delete=models.CASCADE, related_name='participants')
    points_earned = models.IntegerField(default=0)
    is_completed = models.BooleanField(default=False)
    joined_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.activity.name}"

class Notification(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='notifications')
    title = models.CharField(max_length=100)
    content = models.TextField()
    is_read = models.BooleanField(default=False)
    notification_type = models.CharField(max_length=20, default='system')
    type = models.CharField(max_length=20, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
