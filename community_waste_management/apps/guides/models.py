from django.db import models

class GuideCategory(models.Model):
    name = models.CharField(max_length=50)
    icon_url = models.CharField(max_length=200, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class GuideItem(models.Model):
    category = models.ForeignKey(GuideCategory, on_delete=models.CASCADE, related_name='guide_items')
    title = models.CharField(max_length=100)
    content = models.TextField()
    image_url = models.CharField(max_length=200, blank=True, null=True)
    video_url = models.CharField(max_length=200, blank=True, null=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title

class FAQ(models.Model):
    question = models.CharField(max_length=200)
    answer = models.TextField()
    category = models.CharField(max_length=50, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.question
