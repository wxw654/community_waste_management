from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    ROLE_CHOICES = [
        ('resident', '居民'),
        ('admin', '管理员'),
        ('inspector', '巡检员'),
        ('property', '物业'),
    ]
    role = models.CharField(max_length=20, choices=ROLE_CHOICES, default='resident')
    phone_number = models.CharField(max_length=15, blank=True, null=True)
    wechat_openid = models.CharField(max_length=100, blank=True, null=True)
    family_members = models.IntegerField(default=1, blank=True, null=True)
    points = models.IntegerField(default=0)
    level = models.CharField(max_length=20, default='新手')
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class House(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='houses')
    building = models.CharField(max_length=50)
    unit = models.CharField(max_length=20)
    room = models.CharField(max_length=20)
    is_verified = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.building}-{self.unit}-{self.room}"
