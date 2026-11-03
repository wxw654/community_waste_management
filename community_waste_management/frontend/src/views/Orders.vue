<template>
  <div class="orders">
    <el-page-header @back="$router.push('/products')" content="我的兑换订单"></el-page-header>
    <el-card style="margin-top: 1.5rem;">
      <el-table :data="ordersData" stripe style="width: 100%">
        <el-table-column prop="id" label="订单号" width="120">
          <template #default="scope"><strong>#{{ scope.row.id }}</strong></template>
        </el-table-column>
        <el-table-column prop="productName" label="商品名称" width="150"></el-table-column>
        <el-table-column prop="totalPoints" label="消耗积分" width="120">
          <template #default="scope"><span style="color: #f56c6c;">-{{ scope.row.totalPoints }}</span></template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100">
          <template #default="scope">
            <el-tag :type="scope.row.status === '已完成' ? 'success' : scope.row.status === '待领取' ? 'warning' : 'info'" size="small">{{ scope.row.status }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createdAt" label="下单时间"></el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'Orders',
  data() {
    return {
      ordersData: [
        { id: 1001, productName: '洗衣液', totalPoints: 200, status: '已完成', createdAt: '2026-04-01 10:30' },
        { id: 1002, productName: '抽纸', totalPoints: 300, status: '待领取', createdAt: '2026-04-03 15:20' },
        { id: 1003, productName: '垃圾袋', totalPoints: 300, status: '已完成', createdAt: '2026-03-28 09:00' }
      ]
    }
  }
}
</script>

<style scoped>
.orders { padding: 1rem; }
</style>
