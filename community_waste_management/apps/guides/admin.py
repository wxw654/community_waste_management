from django.contrib import admin
from .models import GuideCategory, GuideItem, FAQ


class GuideItemInline(admin.TabularInline):
    model = GuideItem
    extra = 1
    fields = ('title', 'content', 'is_active')


@admin.register(GuideCategory)
class GuideCategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'created_at')
    search_fields = ('name',)
    inlines = [GuideItemInline]
    list_per_page = 15


@admin.register(GuideItem)
class GuideItemAdmin(admin.ModelAdmin):
    list_display = ('title', 'category', 'is_active', 'updated_at', 'created_at')
    list_filter = ('category', 'is_active', 'created_at')
    search_fields = ('title', 'content')
    list_editable = ('is_active',)
    list_per_page = 15
    ordering = ('-created_at',)
    fieldsets = (
        ('指南信息', {
            'fields': ('category', 'title', 'content'),
            'classes': ('wide',)
        }),
        ('媒体资源', {
            'fields': ('image_url', 'video_url'),
            'classes': ('collapse',),
        }),
        ('状态', {
            'fields': ('is_active',),
        }),
    )


@admin.register(FAQ)
class FAQAdmin(admin.ModelAdmin):
    list_display = ('question', 'category', 'created_at')
    list_filter = ('category',)
    search_fields = ('question', 'answer')
    list_per_page = 15
    ordering = ('-created_at',)
    fieldsets = (
        ('问题与答案', {
            'fields': ('question', 'answer', 'category'),
        }),
    )
