from django.contrib import admin
from .models import Feedback, PointEvaluation, ViolationReport


@admin.register(Feedback)
class FeedbackAdmin(admin.ModelAdmin):
    list_display = ('user', 'title', 'status', 'created_at')
    list_filter = ('status', 'created_at')
    search_fields = ('user__username', 'title', 'content')
    list_editable = ('status',)
    list_per_page = 15
    ordering = ('-created_at',)
    fieldsets = (
        ('反馈信息', {
            'fields': ('user', 'title', 'content', 'image_url'),
        }),
        ('处理状态', {
            'fields': ('status',),
        }),
    )

    def get_status_color(self, obj):
        color_map = {'pending': 'orange', 'processed': 'green', 'closed': 'gray'}
        return color_map.get(obj.status, '')
    get_status_color.short_description = '状态颜色'


@admin.register(PointEvaluation)
class PointEvaluationAdmin(admin.ModelAdmin):
    list_display = ('user', 'waste_point', 'cleanliness', 'equipment_status', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('user__username', 'waste_point__name', 'comment')
    list_per_page = 15
    ordering = ('-created_at',)
    fieldsets = (
        ('评价信息', {
            'fields': ('user', 'waste_point', 'cleanliness', 'equipment_status'),
        }),
        ('详细内容', {
            'fields': ('comment', 'image_url'),
            'classes': ('collapse',),
        }),
    )


@admin.register(ViolationReport)
class ViolationReportAdmin(admin.ModelAdmin):
    list_display = ('reporter', 'user', 'waste_point', 'status', 'created_at')
    list_filter = ('status', 'created_at')
    search_fields = ('reporter__username', 'user__username', 'waste_point__name', 'description')
    list_editable = ('status',)
    list_per_page = 15
    ordering = ('-created_at',)
    fieldsets = (
        ('举报信息', {
            'fields': ('reporter', 'user', 'waste_point', 'description', 'image_url'),
        }),
        ('处理状态', {
            'fields': ('status',),
        }),
    )
