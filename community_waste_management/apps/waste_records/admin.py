from django.contrib import admin
from .models import WasteCategory, WasteRecord, PointTransaction


@admin.register(WasteCategory)
class WasteCategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'point_value', 'description', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('name', 'description')
    list_editable = ('point_value',)
    list_per_page = 15
    ordering = ('name',)


@admin.register(WasteRecord)
class WasteRecordAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'waste_point', 'category', 'weight', 'points_earned', 'is_qualified', 'created_at')
    list_filter = ('category', 'is_qualified', 'waste_point', 'created_at')
    search_fields = ('user__username', 'waste_point__name')
    list_editable = ('is_qualified',)
    list_per_page = 15
    ordering = ('-created_at',)
    raw_id_fields = ('user', 'waste_point')


@admin.register(PointTransaction)
class PointTransactionAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'points', 'transaction_type', 'description', 'related_record', 'created_at')
    list_filter = ('transaction_type', 'created_at')
    search_fields = ('user__username', 'description')
    list_per_page = 15
    ordering = ('-created_at',)
    raw_id_fields = ('user',)

    def get_transaction_type_color(self, obj):
        return 'green' if obj.transaction_type == 'earn' else 'red'
    get_transaction_type_color.short_description = '类型颜色'
