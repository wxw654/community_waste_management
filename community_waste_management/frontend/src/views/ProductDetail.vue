<template>
  <div class="product-detail">
    <el-page-header @back="$router.push('/products')" content="商品详情"></el-page-header>
    <el-card style="margin-top: 1.5rem;">
      <h3>{{ productName }} - 商品详情</h3>
      <el-row :gutter="30" style="margin-top: 1.5rem;">
        <el-col :span="10">
          <img src="https://via.placeholder.com/400x400?text=商品图片" alt="" style="width: 100%; border-radius: 8px;">
        </el-col>
        <el-col :span="14">
          <p style="font-size: 0.95rem; color: #666; line-height: 1.8;">这是一款优质的商品，品质保证，值得信赖。</p>
          <div style="margin-top: 2rem;">
            <span style="font-size: 2rem; color: #f56c6c; font-weight: bold;">{{ currentPoints }}</span>
            <span style="font-size: 1.1rem; color: #f56c6c; margin-left: 0.5rem;">积分</span>
          </div>
          <div style="margin-top: 1rem;">
            <el-tag type="success">库存充足</el-tag>
          </div>
          <el-button type="primary" size="large" style="margin-top: 2rem; width: 100%;">立即兑换</el-button>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'ProductDetail',
  computed: {
    productName() {
      const map = { '1': '洗衣液', '2': '抽纸', '3': '洗洁精', '4': '垃圾袋', '5': '环保购物袋', '6': '保温水杯' }
      return map[this.$route.params.id] || '商品'
    },
    currentPoints() {
      const map = { '1': 200, '2': 150, '3': 180, '4': 100, '5': 250, '6': 350 }
      return map[this.$route.params.id] || 0
    }
  }
}
</script>

<style scoped>
.product-detail { padding: 1rem; }
</style>
