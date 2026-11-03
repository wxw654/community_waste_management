<template>
  <div class="activity-detail">
    <el-page-header @back="$router.push('/activities')" content="活动详情"></el-page-header>
    <el-card style="margin-top: 1.5rem;">
      <h3>{{ activityName }} - 活动详情</h3>
      <div style="margin-top: 1.5rem;">
        <el-descriptions title="" :column="2" border>
          <el-descriptions-item label="开始时间">2026-04-01</el-descriptions-item>
          <el-descriptions-item label="结束时间">2026-04-15</el-descriptions-item>
          <el-descriptions-item label="活动地点">社区活动室</el-descriptions-item>
          <el-descriptions-item label="已报名人数">128 人</el-descriptions-item>
          <el-descriptions-item label="活动奖励"><span style="color: #f56c6c; font-weight: bold;">500 积分</span></el-descriptions-item>
        </el-descriptions>
      </div>
      <div style="margin-top: 1.5rem;">
        <h4>活动介绍</h4>
        <p style="color: #666; line-height: 1.8; margin-top: 0.5rem;">这是一项非常有意义的社区环保活动，欢迎各位居民积极参与，共同为建设美好家园贡献力量。</p>
      </div>
      <div style="margin-top: 2rem; text-align: center;">
        <el-button type="primary" size="large">立即报名参加</el-button>
        <el-button size="large" @click="$router.push('/activities')">返回列表</el-button>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'ActivityDetail',
  computed: {
    activityName() {
      const map = { '1': '垃圾分类知识竞赛', '2': '厨余垃圾变肥料活动', '3': '分类达人评选' }
      return map[this.$route.params.id] || '活动'
    }
  }
}
</script>

<style scoped>
.activity-detail { padding: 1rem; }
</style>
