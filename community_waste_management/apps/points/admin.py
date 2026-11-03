from django.contrib import admin
from .models import WastePoint, Sensor


class SensorInline(admin.TabularInline):
    model = Sensor
    extra = 1
    fields = ('sensor_type', 'sensor_id', 'is_active', 'last_reading')


@admin.register(WastePoint)
class WastePointAdmin(admin.ModelAdmin):
    list_display = ('name', 'location', 'type', 'status', 'fill_level', 'capacity', 'open_time', 'close_time')
    list_filter = ('status', 'type')
    search_fields = ('name', 'location')
    list_editable = ('status',)
    list_per_page = 15
    ordering = ('name',)
    inlines = [SensorInline]
    fieldsets = (
        ('基本信息', {
            'fields': ('name', 'location', 'type'),
        }),
        ('坐标信息', {
            'fields': ('latitude', 'longitude'),
            'classes': ('collapse',),
        }),
        ('容量状态', {
            'fields': ('capacity', 'current_fill', 'fill_level', 'status'),
        }),
        ('运营时间', {
            'fields': ('open_time', 'close_time', 'last_cleaned', 'next_cleanup'),
        }),
    )

    def get_fill_level_color(self, obj):
        if obj.fill_level >= 80:
            return 'red'
        elif obj.fill_level >= 50:
            return 'orange'
        return 'green'
    get_fill_level_color.short_description = '填充率颜色'


@admin.register(Sensor)
class SensorAdmin(admin.ModelAdmin):
    list_display = ('waste_point', 'sensor_type', 'sensor_id', 'is_active', 'last_reading', 'created_at')
    list_filter = ('is_active', 'sensor_type')
    search_fields = ('sensor_id', 'waste_point__name')
    list_per_page = 15
    ordering = ('-created_at',)
