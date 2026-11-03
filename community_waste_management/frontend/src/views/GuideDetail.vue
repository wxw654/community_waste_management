<template>
  <div class="guide-detail">
    <el-page-header @back="$router.push('/guides')" :content="categoryName"></el-page-header>
    <el-card style="margin-top: 1.5rem;">
      <h3>{{ categoryName }} - 详细说明</h3>
      <p>这是 {{ categoryName }} 的详细分类指南页面。</p>
      <div class="detail-info">
        <el-descriptions title="" :column="1" border>
          <el-descriptions-item label="类别代码">{{ $route.params.category }}</el-descriptions-item>
          <el-descriptions-item label="投放要求">请按照相关规定正确投放</el-descriptions-item>
          <el-descriptions-item label="注意事项">保持清洁，避免污染其他垃圾</el-descriptions-item>
        </el-descriptions>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'GuideDetail',
  computed: {
    categoryName() {
      const map = { 'A': '可回收物', 'B': '厨余垃圾', 'C': '有害垃圾', 'D': '其他垃圾' }
      return map[this.$route.params.category] || '未知分类'
    }
  }
}
</script>

<style scoped>
.guide-detail { padding: 1rem; }
.detail-info { margin-top: 1rem; }
</style>
