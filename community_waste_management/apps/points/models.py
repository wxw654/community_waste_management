from django.db import models

class WastePoint(models.Model):
    STATUS_CHOICES = [
        ('normal', '正常'),
        ('full', '满溢'),
        ('warning', '警告'),
        ('offline', '离线'),
        ('maintenance', '维护中'),
    ]
    name = models.CharField(max_length=100)
    location = models.CharField(max_length=200)
    latitude = models.FloatField(blank=True, null=True)
    longitude = models.FloatField(blank=True, null=True)
    type = models.CharField(max_length=50)
    capacity = models.IntegerField(default=100)
    current_fill = models.FloatField(default=0)
    fill_level = models.IntegerField(default=0)
    accepted_categories = models.CharField(max_length=200, blank=True, null=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='normal')
    next_cleanup = models.DateTimeField(blank=True, null=True)
    open_time = models.TimeField(blank=True, null=True)
    close_time = models.TimeField(blank=True, null=True)
    last_cleaned = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

class Sensor(models.Model):
    waste_point = models.ForeignKey(WastePoint, on_delete=models.CASCADE, related_name='sensors')
    sensor_type = models.CharField(max_length=50)
    sensor_id = models.CharField(max_length=100)
    is_active = models.BooleanField(default=True)
    last_reading = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
