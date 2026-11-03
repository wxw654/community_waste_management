from django.contrib import admin
from .models import Product, Order


class OrderInline(admin.TabularInline):
    model = Order
    extra = 1
    fields = ('user', 'quantity', 'total_points', 'status')
    readonly_fields = ('created_at',)


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('name', 'points_required', 'price', 'stock', 'is_active', 'created_at')
    list_filter = ('is_active',)
    search_fields = ('name', 'description')
    list_editable = ('is_active', 'stock', 'price')
    list_per_page = 15
    ordering = ('-created_at',)
    inlines = [OrderInline]
    fieldsets = (
        ('商品信息', {
            'fields': ('name', 'description', 'image_url'),
        }),
        ('价格库存', {
            'fields': ('points_required', 'price', 'stock'),
        }),
        ('状态', {
            'fields': ('is_active',),
        }),
    )

    def get_stock_status(self, obj):
        if obj.stock <= 5:
            return 'low'
        elif obj.stock <= 20:
            return 'medium'
        return 'normal'
    get_stock_status.short_description = '库存状态'


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'product', 'quantity', 'total_points', 'status', 'created_at')
    list_filter = ('status', 'created_at', 'product')
    search_fields = ('user__username', 'product__name')
    list_editable = ('status',)
    list_per_page = 15
    ordering = ('-created_at',)
    raw_id_fields = ('user', 'product')

    def get_status_color(self, obj):
        color_map = {'pending': 'orange', 'completed': 'green', 'cancelled': 'red'}
        return color_map.get(obj.status, '')
    get_status_color.short_description = '状态颜色'
