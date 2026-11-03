from django.contrib import admin
from .models import User, House


class HouseInline(admin.TabularInline):
    model = House
    extra = 1
    fields = ('building', 'unit', 'room', 'is_verified')


@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = ('username', 'email', 'role', 'phone_number', 'points', 'level', 'is_active', 'created_at')
    list_filter = ('role', 'is_active', 'level', 'created_at')
    search_fields = ('username', 'email', 'phone_number')
    list_editable = ('role', 'is_active')
    list_per_page = 15
    ordering = ('-created_at',)
    inlines = [HouseInline]
    fieldsets = (
        ('基本信息', {
            'fields': ('username', 'email', 'password'),
            'classes': ('wide',)
        }),
        ('个人信息', {
            'fields': ('first_name', 'last_name', 'phone_number', 'wechat_openid', 'family_members'),
        }),
        ('权限设置', {
            'fields': ('role', 'is_active', 'is_staff', 'is_superuser'),
        }),
        ('积分等级', {
            'fields': ('points', 'level'),
        }),
    )
    readonly_fields = ('created_at', 'updated_at')

    def save_model(self, request, obj, form, change):
        if obj.password and not obj.password.startswith('pbkdf2_sha256$'):
            obj.set_password(obj.password)
        super().save_model(request, obj, form, change)


@admin.register(House)
class HouseAdmin(admin.ModelAdmin):
    list_display = ('user', 'building', 'unit', 'room', 'is_verified', 'created_at')
    list_filter = ('is_verified', 'building')
    search_fields = ('user__username', 'building', 'room')
    list_per_page = 15
