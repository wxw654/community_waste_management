from django.contrib import admin
from .models import Activity, ActivityParticipant, Notification


class ActivityParticipantInline(admin.TabularInline):
    model = ActivityParticipant
    extra = 1
    fields = ('user', 'points_earned', 'is_completed')
    readonly_fields = ('joined_at',)


@admin.register(Activity)
class ActivityAdmin(admin.ModelAdmin):
    list_display = ('title', 'start_date', 'end_date', 'reward_points', 'is_active', 'created_at')
    list_filter = ('is_active', 'start_date', 'end_date')
    search_fields = ('title', 'name', 'description')
    list_editable = ('is_active',)
    list_per_page = 15
    ordering = ('-start_date',)
    inlines = [ActivityParticipantInline]
    fieldsets = (
        ('活动信息', {
            'fields': ('title', 'name', 'description'),
        }),
        ('时间安排', {
            'fields': ('start_date', 'end_date'),
        }),
        ('奖励设置', {
            'fields': ('reward_points', 'is_active'),
        }),
    )


@admin.register(ActivityParticipant)
class ActivityParticipantAdmin(admin.ModelAdmin):
    list_display = ('user', 'activity', 'points_earned', 'is_completed', 'joined_at')
    list_filter = ('is_completed', 'activity')
    search_fields = ('user__username', 'activity__title')
    list_per_page = 15
    ordering = ('-joined_at',)


@admin.register(Notification)
class NotificationAdmin(admin.ModelAdmin):
    list_display = ('user', 'title', 'notification_type', 'is_read', 'created_at')
    list_filter = ('notification_type', 'is_read', 'created_at')
    search_fields = ('user__username', 'title', 'content')
    list_editable = ('is_read',)
    list_per_page = 15
    ordering = ('-created_at',)
