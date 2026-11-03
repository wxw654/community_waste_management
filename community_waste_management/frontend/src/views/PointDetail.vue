<template>
  <div class="point-detail">
    <el-page-header @back="$router.push('/points')" content="投放点详情"></el-page-header>
    <el-card style="margin-top: 1.5rem;">
      <h3>{{ pointName }} - 详细信息</h3>
      <el-descriptions title="" :column="2" border style="margin-top: 1rem;">
        <el-descriptions-item label="名称">{{ pointName }}</el-descriptions-item>
        <el-descriptions-item label="ID">{{ $route.params.id }}</el-descriptions-item>
        <el-descriptions-item label="位置">社区内部</el-descriptions-item>
        <el-descriptions-item label="状态"><el-tag type="success">正常</el-tag></el-descriptions-item>
      </el-descriptions>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'PointDetail',
  computed: {
    pointName() {
      const map = { '1': '小区东门投放点', '2': '1号楼投放点', '3': '中心花园投放点', '4': '2号楼投放点' }
      return map[this.$route.params.id] || '投放点'
    }
  }
}
</script>

<style scoped>
.point-detail { padding: 1rem; }
</style>
