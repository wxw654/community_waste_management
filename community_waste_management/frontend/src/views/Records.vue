<template>
  <div class="records">
    <el-tabs v-model="activeTab" @tab-click="handleTabClick" class="records-tabs">
      <el-tab-pane label="垃圾投放记录" name="list">
        <div class="page-header"><h2>我的投放记录</h2></div>
        <el-card class="stats-card">
          <el-row :gutter="20">
            <el-col :span="6"><div class="stat-item"><div class="stat-number">{{ totalWeight }}</div><div class="stat-label">总投放重量 (kg)</div></div></el-col>
            <el-col :span="6"><div class="stat-item"><div class="stat-number points">{{ totalPoints }}</div><div class="stat-label">总获得积分</div></div></el-col>
            <el-col :span="6"><div class="stat-item"><div class="stat-number">{{ totalCount }}</div><div class="stat-label">总投放次数</div></div></el-col>
            <el-col :span="6"><div class="stat-item"><div class="stat-number">{{ avgPoints }}</div><div class="stat-label">平均每次积分</div></div></el-col>
          </el-row>
        </el-card>
        <el-card class="filter-card" style="margin-top: 1.5rem;">
          <el-form :inline="true" :model="form" label-width="100px">
            <el-form-item label="开始日期"><el-date-picker v-model="form.startDate" type="date" placeholder="选择开始日期" value-format="YYYY-MM-DD" style="width:180px" clearable></el-date-picker></el-form-item>
            <el-form-item label="结束日期"><el-date-picker v-model="form.endDate" type="date" placeholder="选择结束日期" value-format="YYYY-MM-DD" style="width:180px" clearable></el-date-picker></el-form-item>
            <el-form-item label="垃圾类别">
              <el-select v-model="form.category" placeholder="选择类别" clearable style="width:180px" @change="handleCategoryChange">
                <el-option label="全部" value=""></el-option>
                <el-option v-for="cat in categories" :key="cat.id" :label="cat.name" :value="cat.name"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item><el-button type="primary" @click="filterRecords">查询</el-button><el-button @click="resetFilter">重置</el-button></el-form-item>
          </el-form>
        </el-card>
        <el-card style="margin-top:1.5rem;">
          <template #header><span>投放记录列表（共 {{ filteredRecords.length }} 条）</span></template>
          <el-table :data="paginatedRecords" stripe v-loading="loading" style="width:100%">
            <el-table-column prop="created_at" label="投放日期" width="180"><template #default="scope">{{ formatDate(scope.row.created_at) }}</template></el-table-column>
            <el-table-column prop="category.name" label="垃圾类别" width="160">
              <template #default="scope"><el-tag :type="getCatType(scope.row.category?.name)">{{ scope.row.category?.name }}</el-tag></template>
            </el-table-column>
            <el-table-column prop="waste_point.name" label="投放点" width="180"></el-table-column>
            <el-table-column prop="weight" label="重量(kg)" width="100"><template #default="scope"><strong>{{ scope.row.weight }}</strong></template></el-table-column>
            <el-table-column prop="points_earned" label="获得积分" width="110"><template #default="scope"><span style="color:#f56c6c;font-weight:bold;">+{{ scope.row.points_earned }}</span></template></el-table-column>
            <el-table-column prop="is_qualified" label="状态" width="100"><template #default="scope"><el-tag :type="scope.row.is_qualified?'success':'danger'" effect="dark">{{ scope.row.is_qualified?'合格':'不合格' }}</el-tag></template></el-table-column>
          </el-table>
          <div class="pagination-wrapper" style="margin-top:2rem;display:flex;justify-content:flex-end;">
            <el-pagination v-model:current-page="currentPage" v-model:page-size="pageSize" :page-sizes="[5,10,20]" :total="filteredRecords.length" layout="total,sizes,prev,pager,next,jumper" @size-change="handleSizeChange" @current-change="handleCurrentChange"></el-pagination>
          </div>
        </el-card>
      </el-tab-pane>

      <el-tab-pane label="垃圾投放统计" name="statistics">
        <div class="page-header"><h2>垃圾投放数据统计</h2></div>
        <el-row :gutter="20" style="margin-bottom:1.5rem;">
          <el-col :span="12"><el-card style="height:400px;"><template #header><span>各类垃圾投放量统计</span></template><div ref="catChart" style="height:320px;"></div></el-card></el-col>
          <el-col :span="12"><el-card style="height:400px;"><template #header><span>每日投放趋势</span></template><div ref="trendChart" style="height:320px;"></div></el-card></el-col>
        </el-row>
      </el-tab-pane>

      <el-tab-pane label="创建投放记录" name="create">
        <div class="page-header"><h2>创建新的投放记录</h2></div>
        <el-card style="max-width:700px;">
          <el-form :model="createForm" label-width="120px" size="large">
            <el-form-item label="投放日期"><el-date-picker v-model="createForm.date" type="datetime" placeholder="选择时间" value-format="YYYY-MM-DD HH:mm:ss" style="width:100%"></el-date-picker></el-form-item>
            <el-form-item label="投放点">
              <el-select v-model="createForm.pointId" placeholder="请选择" style="width:100%">
                <el-option v-for="p in wastePoints" :key="p.id" :label="p.name" :value="p.id"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="垃圾类别">
              <el-radio-group v-model="createForm.categoryId">
                <el-radio-button v-for="cat in categories" :key="cat.id" :label="cat.id">{{ cat.name }}</el-radio-button>
              </el-radio-group>
            </el-form-item>
            <el-form-item label="重量(kg)">
              <el-input-number v-model="createForm.weight" :min="0.1" :max="100" :step="0.1" :precision="1" style="width:200px;"></el-input-number>
              <span style="margin-left:1rem;color:#909399;">预计：{{ calcPoints }} 分</span>
            </el-form-item>
            <el-form-item label="备注"><el-input v-model="createForm.remark" type="textarea" :rows="3" placeholder="可选"></el-input></el-form-item>
            <el-form-item><el-button type="primary" size="large" @click="submitRecord" :loading="submitting">提交记录</el-button><el-button size="large" @click="resetCreateForm">重置</el-button></el-form-item>
          </el-form>
        </el-card>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { ElMessage } from 'element-plus'
import axios from 'axios'

export default {
  name:'Records',
  data() {
    return {
      activeTab:'list',
      form:{startDate:'',endDate:'',category:''},
      currentPage:1,
      pageSize:10,
      loading:false,
      submitting:false,
      totalWeight:0,
      totalPoints:0,
      totalCount:0,
      avgPoints:0,
      allRecordsData:[],
      categories:[],
      wastePoints:[],
      createForm:{date:'',pointId:null,categoryId:null,weight:1.0,remark:''},
      catChart:null,
      trendChart:null
    }
  },
  computed:{
    filteredRecords(){
      let r=[...this.allRecordsData]
      if(this.form.startDate) r=r.filter(x=>x.created_at && x.created_at.startsWith(this.form.startDate))
      if(this.form.endDate) r=r.filter(x=>x.created_at && x.created_at.startsWith(this.form.endDate))
      if(this.form.category) r=r.filter(x=>x.category?.name===this.form.category)
      return r
    },
    paginatedRecords(){ const s=(this.currentPage-1)*this.pageSize; return this.filteredRecords.slice(s,s+this.pageSize) },
    calcPoints(){
      const category = this.categories.find(c => c.id === this.createForm.categoryId)
      const pointValue = category ? category.point_value : 10
      return Math.round(this.createForm.weight * pointValue)
    }
  },
  mounted() {
    this.loadCategories()
    this.loadWastePoints()
    this.loadRecords()
  },
  methods:{
    handleTabClick(t){
      this.activeTab=t.props.name
      if(t.props.name==='statistics') this.$nextTick(()=>setTimeout(()=>this.initCharts(),100))
    },

    async loadCategories() {
      try {
        const res = await axios.get('/api/waste-categories/')
        this.categories = res.data.results || res.data || []
      } catch (error) {
        console.error('加载分类失败:', error)
      }
    },

    async loadWastePoints() {
      try {
        const res = await axios.get('/api/waste-points/')
        this.wastePoints = res.data.results || res.data || []
      } catch (error) {
        console.error('加载投放点失败:', error)
      }
    },

    async loadRecords() {
      this.loading = true
      try {
        const res = await axios.get('/api/waste-records/')
        this.allRecordsData = res.data.results || res.data || []
        this.calculateStats()
      } catch (error) {
        console.error('加载记录失败:', error)
        ElMessage.error('加载记录失败')
      } finally {
        this.loading = false
      }
    },

    calculateStats() {
      let totalWeight = 0
      let totalPoints = 0

      this.allRecordsData.forEach(record => {
        totalWeight += record.weight || 0
        totalPoints += record.points_earned || 0
      })

      this.totalWeight = totalWeight.toFixed(1)
      this.totalPoints = totalPoints.toString()
      this.totalCount = this.allRecordsData.length.toString()
      this.avgPoints = this.allRecordsData.length > 0
        ? (totalPoints / this.allRecordsData.length).toFixed(2)
        : '0'
    },

    filterRecords(){ ElMessage.success(`筛选完成，${this.filteredRecords.length}条`) },
    resetFilter(){ this.form={startDate:'',endDate:'',category:''} },
    handleCategoryChange(v){ this.form.category=v||'' },
    handleSizeChange(s){ this.pageSize=s }, handleCurrentChange(c){ this.currentPage=c },

    formatDate(dateStr) {
      if (!dateStr) return ''
      return dateStr.substring(0, 16).replace('T', ' ')
    },

    getCatType(c){ return{'可回收物':'','厨余垃圾（湿垃圾）':'success','有害垃圾':'danger','其他垃圾（干垃圾）':'warning'}[c]||'' },

    async submitRecord(){
      if(!this.createForm.date || !this.createForm.pointId || !this.createForm.categoryId){
        ElMessage.warning('请填写完整信息')
        return
      }

      this.submitting = true
      try {
        await axios.post('/api/waste-records/', {
          weight: this.createForm.weight,
          points_earned: this.calcPoints,
          is_qualified: true,
          category: this.createForm.categoryId,
          waste_point: this.createForm.pointId
        })

        ElMessage.success('提交成功！')
        this.resetCreateForm()
        this.activeTab='list'
        this.loadRecords()
      } catch (error) {
        console.error('提交失败:', error)
        ElMessage.error('提交失败，请重试')
      } finally {
        this.submitting = false
      }
    },

    resetCreateForm(){ this.createForm={date:'',pointId:null,categoryId:this.categories[0]?.id||null,weight:1.0,remark:''} },

    initCharts(){
      if(this.$echarts){
        const c=this.refs.catChart; if(c){
          if(this.catChart)this.catChart.dispose()
          this.catChart=this.$echarts.init(c)

          const categoryStats = {}
          this.allRecordsData.forEach(record => {
            const catName = record.category?.name || '其他'
            if (!categoryStats[catName]) {
              categoryStats[catName] = 0
            }
            categoryStats[catName] += record.weight || 0
          })

          const pieData = Object.entries(categoryStats).map(([name, value]) => ({ value, name }))

          this.catChart.setOption({
            tooltip:{trigger:'item'},
            legend:{bottom:0},
            series:[{
              type:'pie',
              radius:['40%','70%'],
              data: pieData.length > 0 ? pieData : [{value:420,name:'可回收'},{value:380,name:'厨余'},{value:45,name:'有害'},{value:280,name:'其他'}],
              color:['#409eff','#67c23a','#f56c6c','#e6a23c']
            }]
          })
        }

        const t=this.refs.trendChart; if(t){
          if(this.trendChart)this.trendChart.dispose()
          this.trendChart=this.$echarts.init(t)

          const dailyStats = {}
          this.allRecordsData.forEach(record => {
            if (record.created_at) {
              const day = record.created_at.substring(0, 10)
              if (!dailyStats[day]) {
                dailyStats[day] = 0
              }
              dailyStats[day] += record.points_earned || 0
            }
          })

          const sortedDays = Object.keys(dailyStats).sort()
          const dates = sortedDays.map(d => d.substring(5))
          const values = sortedDays.map(d => dailyStats[d])

          this.trendChart.setOption({
            tooltip:{trigger:'axis'},
            xAxis:{type:'category',data:dates.length > 0 ? dates : ['03/26','03/27','03/28','03/29','03/30','03/31','04/01','04/02']},
            yAxis:{type:'value'},
            series:[{
              type:'line',
              smooth:true,
              data:values.length > 0 ? values : [18,42,28,35,25,38,30,52],
              areaStyle:{color:'#409eff'}
            }]
          })
        }
      }
    }
  },
  beforeUnmount(){ if(this.catChart)this.catChart.dispose(); if(this.trendChart)this.trendChart.dispose() }
}
</script>

<style scoped>
.records{padding:1rem;}
.records-tabs{background:white;border-radius:8px;box-shadow:0 2px 12px rgba(0,0,0,0.1);}
.page-header h2{font-size:1.5rem;color:#333;margin-bottom:1.5rem;}
.stats-card .stat-item{text-align:center;padding:1.5rem;background:linear-gradient(135deg,#667eea,#764ba2);border-radius:12px;color:white;}
.stat-number{font-size:2.5rem;font-weight:bold;} .stat-number.points{color:#ffd700;}
.stat-label{font-size:.95rem;opacity:.9;}
</style>
