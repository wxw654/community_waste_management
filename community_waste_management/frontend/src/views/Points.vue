<template>
  <div class="points">
    <el-tabs v-model="activeTab" @tab-click="handleTabClick" class="points-tabs">
      <el-tab-pane label="投放点查询" name="list">
        <div class="page-header">
          <h2>垃圾投放点查询</h2>
        </div>

        <el-card class="filter-card">
          <el-form :inline="true" :model="form" label-width="100px">
            <el-form-item label="投放点类型">
              <el-select
                v-model="form.type"
                placeholder="选择类型"
                clearable
                @change="handleTypeChange"
                style="width: 180px"
              >
                <el-option label="全部" value=""></el-option>
                <el-option label="可回收垃圾" value="recyclable"></el-option>
                <el-option label="厨余垃圾" value="kitchen"></el-option>
                <el-option label="有害垃圾" value="harmful"></el-option>
                <el-option label="其他垃圾" value="other"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="状态">
              <el-select
                v-model="form.status"
                placeholder="选择状态"
                clearable
                @change="handleStatusChange"
                style="width: 180px"
              >
                <el-option label="全部" value=""></el-option>
                <el-option label="正常" value="normal"></el-option>
                <el-option label="警告" value="warning"></el-option>
                <el-option label="满溢" value="full"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="filterPoints">筛选</el-button>
              <el-button @click="resetFilter">重置</el-button>
            </el-form-item>
          </el-form>
        </el-card>

        <el-card class="points-list-card">
          <template #header>
            <div class="card-header">
              <span>投放点列表（共 {{ filteredPoints.length }} 个）</span>
            </div>
          </template>

          <el-table
            :data="filteredPoints"
            style="width: 100%"
            stripe
            highlight-current-row
            @row-click="viewDetails"
          >
            <el-table-column prop="name" label="投放点名称" width="180"></el-table-column>
            <el-table-column prop="location" label="位置" width="250"></el-table-column>
            <el-table-column prop="type" label="类型" width="120">
              <template #default="scope">
                <el-tag :type="getTypeTagType(scope.row.type)">
                  {{ scope.row.type }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="capacity" label="容量(L)" width="100"></el-table-column>
            <el-table-column prop="fillLevel" label="填充度" width="150">
              <template #default="scope">
                <el-progress
                  :percentage="scope.row.fillLevel"
                  :status="getFillStatus(scope.row.fillLevel)"
                  :stroke-width="15"
                ></el-progress>
              </template>
            </el-table-column>
            <el-table-column prop="status" label="状态" width="100">
              <template #default="scope">
                <el-tag :type="getStatusType(scope.row.status)" effect="dark">
                  {{ scope.row.statusText }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="150" fixed="right">
              <template #default="scope">
                <el-button size="small" type="primary" @click.stop="viewDetails(scope.row)">
                  查看详情
                </el-button>
              </template>
            </el-table-column>
          </el-table>

          <div class="pagination-wrapper">
            <el-pagination
              v-model:current-page="currentPage"
              v-model:page-size="pageSize"
              :page-sizes="[5, 10, 20]"
              :total="filteredPoints.length"
              layout="total, sizes, prev, pager, next, jumper"
              @size-change="handleSizeChange"
              @current-change="handleCurrentChange"
            ></el-pagination>
          </div>
        </el-card>
      </el-tab-pane>

      <el-tab-pane label="投放点详情" name="detail">
        <div class="page-header">
          <h2 v-if="selectedPoint">{{ selectedPoint.name }} - 详细信息</h2>
          <h2 v-else>请从列表中选择一个投放点查看详情</h2>
        </div>

        <div v-if="selectedPoint" class="detail-content">
          <el-row :gutter="20">
            <el-col :span="12">
              <el-card class="info-card">
                <template #header><span>基本信息</span></template>
                <el-descriptions :column="1" border>
                  <el-descriptions-item label="投放点名称">{{ selectedPoint.name }}</el-descriptions-item>
                  <el-descriptions-item label="位置">{{ selectedPoint.location }}</el-descriptions-item>
                  <el-descriptions-item label="类型">
                    <el-tag :type="getTypeTagType(selectedPoint.type)">{{ selectedPoint.type }}</el-tag>
                  </el-descriptions-item>
                  <el-descriptions-item label="容量">{{ selectedPoint.capacity }} L</el-descriptions-item>
                  <el-descriptions-item label="当前填充度">
                    <el-progress :percentage="selectedPoint.fillLevel" :status="getFillStatus(selectedPoint.fillLevel)"></el-progress>
                  </el-descriptions-item>
                  <el-descriptions-item label="运行状态">
                    <el-tag :type="getStatusType(selectedPoint.status)" effect="dark">{{ selectedPoint.statusText }}</el-tag>
                  </el-descriptions-item>
                </el-descriptions>
              </el-card>
            </el-col>
            <el-col :span="12">
              <el-card class="map-card">
                <template #header><span>位置地图</span></template>
                <div class="map-placeholder">
                  <p>{{ selectedPoint.location }}</p>
                  <el-button type="primary" @click="navigateToPoint">导航到此处</el-button>
                </div>
              </el-card>
              <el-card class="time-card" style="margin-top: 20px;">
                <template #header><span>开放时间</span></template>
                <p>开放时间：{{ selectedPoint.openTime || '全天 24 小时' }}</p>
                <p>最后清运：{{ selectedPoint.lastCleaned || '2026-04-05 08:00' }}</p>
              </el-card>
            </el-col>
          </el-row>
        </div>

        <el-empty v-else description="请从投放点查询列表中选择一个投放点"></el-empty>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { ElMessage } from 'element-plus'

export default {
  name: 'Points',
  data() {
    return {
      activeTab: 'list',
      form: { type: '', status: '' },
      currentPage: 1,
      pageSize: 10,
      selectedPoint: null,
      allPointsData: [
        { id: 1, name: '小区东门投放点', location: '小区东门入口左侧', type: '综合', capacity: 200, fillLevel: 30, status: 'normal', statusText: '正常', openTime: '06:00 - 22:00' },
        { id: 2, name: '1号楼投放点', location: '1号楼楼下北侧', type: '厨余垃圾', capacity: 150, fillLevel: 85, status: 'warning', statusText: '警告' },
        { id: 3, name: '2号楼投放点', location: '2号楼楼下南侧', type: '可回收垃圾', capacity: 100, fillLevel: 95, status: 'full', statusText: '满溢' },
        { id: 4, name: '3号楼投放点', location: '3号楼楼下东侧', type: '有害垃圾', capacity: 50, fillLevel: 15, status: 'normal', statusText: '正常' },
        { id: 5, name: '4号楼投放点', location: '4号楼楼下西侧', type: '其他垃圾', capacity: 120, fillLevel: 45, status: 'normal', statusText: '正常' },
        { id: 6, name: '中心花园投放点', location: '小区中心花园旁', type: '综合', capacity: 250, fillLevel: 60, status: 'normal', statusText: '正常' }
      ]
    }
  },
  computed: {
    filteredPoints() {
      let result = [...this.allPointsData]
      if (this.form.type) result = result.filter(p => p.type.includes(this.form.type) || this.form.type === '综合')
      if (this.form.status) result = result.filter(p => p.status === this.form.status)
      return result
    }
  },
  methods: {
    handleTabClick(tab) { this.activeTab = tab.props.name },
    filterPoints() { ElMessage.success(`筛选完成，共找到 ${this.filteredPoints.length} 个投放点`) },
    resetFilter() { this.form = { type: '', status: '' }; ElMessage.info('已重置') },
    handleTypeChange(v) { this.form.type = v || '' },
    handleStatusChange(v) { this.form.status = v || '' },
    viewDetails(row) { this.selectedPoint = row; this.activeTab = 'detail'; ElMessage.success(`查看 ${row.name}`) },
    getFillStatus(lvl) { if (lvl >= 90) return 'exception'; if (lvl >= 70) return 'warning'; return '' },
    getStatusType(s) { return s === 'normal' ? 'success' : s === 'warning' ? 'warning' : 'danger' },
    getTypeTagType(t) { const m = {'综合':'','厨余垃圾':'success','可回收垃圾':'','有害垃圾':'danger','其他垃圾':'info'}; return m[t]||'' },
    handleSizeChange(s) { this.pageSize = s },
    handleCurrentChange(c) { this.currentPage = c },
    navigateToPoint() { ElMessage.info('正在打开导航...') }
  }
}
</script>

<style scoped>
.points { padding: 1rem; }
.points-tabs { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.1); }
.page-header h2 { font-size: 1.5rem; color: #333; margin-bottom: 1.5rem; }
.filter-card { margin-bottom: 1.5rem; }
.card-header { font-weight: bold; }
.pagination-wrapper { margin-top: 2rem; display: flex; justify-content: flex-end; }
.detail-content { animation: fadeIn 0.3s ease; }
@keyframes fadeIn { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
.map-placeholder { padding: 3rem 1rem; text-align: center; background: #f5f7fa; border-radius: 8px; min-height: 200px; display: flex; flex-direction: column; align-items: center; gap: 1rem; }
</style>
