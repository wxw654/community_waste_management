<template>
  <div class="dashboard">
    <div class="page-header"><h2>数据可视化分析</h2></div>

    <el-card class="filter-card">
      <el-form :inline="true" :model="form" label-width="80px">
        <el-form-item label="年份">
          <el-select v-model="form.year" placeholder="选择" @change="handleYearChange" style="width:120px">
            <el-option label="2024" value="2024"></el-option><el-option label="2025" value="2025"></el-option><el-option label="2026" value="2026"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="月份">
          <el-select v-model="form.month" placeholder="选择" clearable @change="handleMonthChange" style="width:120px">
            <el-option v-for="m in 12" :key="m" :label="m+'月'" :value="String(m)"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item><el-button type="primary" @click="searchData">查询</el-button><el-button @click="resetData">重置</el-button></el-form-item>
      </el-form>
    </el-card>

    <div class="stats-cards">
      <el-card v-for="(s,i) in statsData" :key="i" shadow="hover">
        <div style="text-align:center;padding:.8rem;">
          <div :style="{fontSize:'2.5rem',fontWeight:'bold',color:s.color}">{{ s.value }}</div>
          <div style="color:#999;margin-top:.3rem;">{{ s.label }}</div>
        </div>
      </el-card>
    </div>

    <el-row :gutter="20" style="margin-top:1.5rem;">
      <el-col :span="12"><el-card style="height:420px;"><template #header><span>四类垃圾投放统计</span></template><div ref="barChart" class="chart"></div></el-card></el-col>
      <el-col :span="12"><el-card style="height:420px;"><template #header><span>垃圾占比分布</span></template><div ref="pieChart" class="chart"></div></el-card></el-col>
    </el-row>

    <el-card style="margin-top:1.5rem;">
      <template #header><span>最近投放记录</span></template>
      <el-table :data="recentRecords" stripe v-loading="loading" style="width:100%">
        <el-table-column prop="created_at" label="日期" width="180"><template #default="scope">{{ formatDate(scope.row.created_at) }}</template></el-table-column>
        <el-table-column prop="category.name" label="类别" width="140"><template #default="scope"><el-tag :type="getCatType(scope.row.category?.name)" size="small">{{ scope.row.category?.name }}</el-tag></template></el-table-column>
        <el-table-column prop="weight" label="重量(kg)" width="100"></el-table-column>
        <el-table-column prop="points_earned" label="积分" width="100"><template #default="scope"><span style="color:#f56c6c;font-weight:bold;">+{{ scope.row.points_earned }}</span></template></el-table-column>
        <el-table-column prop="is_qualified" label="状态" width="100"><template #default="scope"><el-tag :type="scope.row.is_qualified?'success':'danger'" effect="dark" size="small">{{ scope.row.is_qualified?'合格':'不合格' }}</el-tag></template></el-table-column>
        <el-table-column prop="waste_point.name" label="投放点"></el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import { ElMessage } from 'element-plus'
import axios from 'axios'

export default {
  name:'Dashboard',
  data(){
    return {
      form:{year:'2026',month:''},
      loading:false,
      statsData:[
        {icon:'⚖️',value:'0',label:'总投放重量 (kg)',color:'#409eff'},
        {icon:'📝',value:'0',label:'总投放次数',color:'#67c23a'},
        {icon:'💰',value:'0',label:'获得积分',color:'#f56c6c'},
        {icon:'✅',value:'0%',label:'分类正确率',color:'#e6a23c'}
      ],
      recentRecords:[],
      barChart:null,pieChart:null,
      categoryStats:{}
    }
  },
  mounted(){
    this.loadDashboardData()
    this.$nextTick(()=>setTimeout(()=>this.initCharts(),100))
  },
  methods:{
    handleYearChange(v){ this.form.year=v||'2026' },
    handleMonthChange(v){ this.form.month=v||'' },
    searchData(){ ElMessage.success(`查询 ${this.form.year}年${this.form.month?this.form.month+'月':''}`); this.loadDashboardData(); this.$nextTick(()=>this.updateCharts()) },
    resetData(){ this.form={year:'2026',month:''}; ElMessage.info('已重置'); this.loadDashboardData(); this.$nextTick(()=>this.updateCharts()) },

    async loadDashboardData() {
      this.loading = true
      try {
        const recordsRes = await axios.get('/api/waste-records/?limit=10')
        this.recentRecords = recordsRes.data.results || recordsRes.data || []

        const allRecordsRes = await axios.get('/api/waste-records/')
        const allRecords = allRecordsRes.data.results || allRecordsRes.data || []

        let totalWeight = 0
        let totalPoints = 0
        let qualifiedCount = 0
        this.categoryStats = {}

        allRecords.forEach(record => {
          totalWeight += record.weight || 0
          totalPoints += record.points_earned || 0
          if (record.is_qualified) qualifiedCount++

          const catName = record.category?.name || '其他'
          if (!this.categoryStats[catName]) {
            this.categoryStats[catName] = 0
          }
          this.categoryStats[catName] += record.weight || 0
        })

        const totalCount = allRecords.length
        const accuracyRate = totalCount > 0 ? ((qualifiedCount / totalCount) * 100).toFixed(1) : 0

        this.statsData[0].value = totalWeight.toFixed(1)
        this.statsData[1].value = totalCount.toString()
        this.statsData[2].value = totalPoints.toString()
        this.statsData[3].value = accuracyRate + '%'

        this.$nextTick(() => this.updateCharts())
      } catch (error) {
        console.error('加载数据失败:', error)
        ElMessage.error('加载数据失败，请检查网络连接')
      } finally {
        this.loading = false
      }
    },

    formatDate(dateStr) {
      if (!dateStr) return ''
      return dateStr.substring(0, 16).replace('T', ' ')
    },

    initCharts(){
      if(!this.$echarts) return

      const b=this.$refs.barChart; if(b){
        if(this.barChart)this.barChart.dispose()
        this.barChart=this.$echarts.init(b)

        const categories = Object.keys(this.categoryStats)
        const values = Object.values(this.categoryStats)

        this.barChart.setOption({
          tooltip:{trigger:'axis',axisPointer:{type:'shadow'}},
          grid:{left:'3%',right:'4%',bottom:'3%',containLabel:true},
          xAxis:{type:'category',data:categories.length > 0 ? categories : ['可回收物','厨余垃圾','有害垃圾','其他垃圾'],axisLabel:{rotate:15}},
          yAxis:{type:'value',name:'重量(kg)'},
          series:[{name:'投放量',type:'bar',data:values.length > 0 ? values : [420,380,45,280],itemStyle:{color:new this.$echarts.graphic.LinearGradient(0,0,0,1,[{offset:0,color:'#83bff6'},{offset:1,color:'#409eff'}]),borderRadius:[4,4,0,0]},barWidth:'50%'}]
        })
      }

      const p=this.refs.pieChart; if(p){
        if(this.pieChart)this.pieChart.dispose()
        this.pieChart=this.$echarts.init(p)

        const pieData = Object.entries(this.categoryStats).map(([name, value]) => ({ value, name }))

        this.pieChart.setOption({
          tooltip:{trigger:'item',formatter:'{b}: {c}kg ({d}%)'},
          legend:{bottom:'0',left:'center'},
          series:[{name:'类型',type:'pie',radius:['40%','70%'],center:['50%','45%'],avoidLabelOverlap:false,itemStyle:{borderRadius:10,borderColor:'#fff',borderWidth:2},label:{show:true,formatter:'{b}\n{d}%'},data:pieData.length > 0 ? pieData : [{value:420,name:'可回收物'},{value:380,name:'厨余垃圾'},{value:45,name:'有害垃圾'},{value:280,name:'其他垃圾'}],color:['#409eff','#67c23a','#f56c6c','#e6a23c']}]
        })
      }
    },
    updateCharts(){ if(this.barChart)this.barChart.dispose(); if(this.pieChart)this.pieChart.dispose(); this.initCharts() },
    getCatType(c){ return{'可回收物':'','厨余垃圾（湿垃圾）':'success','有害垃圾':'danger','其他垃圾（干垃圾）':'warning','可回收垃圾':'','厨余垃圾':'success'}[c]||'' }
  },
  beforeUnmount(){ if(this.barChart)this.barChart.dispose(); if(this.pieChart)this.pieChart.dispose() }
}
</script>

<style scoped>
.dashboard{padding:1rem;}
.page-header h2{font-size:1.5rem;color:#333;margin-bottom:1.5rem;}
.filter-card{margin-bottom:1.5rem;}
.stats-cards{display:grid;grid-template-columns:repeat(4,1fr);gap:1rem;}
.chart{height:340px;width:100%;}
@media(max-width:992px){ .stats-cards{grid-template-columns:repeat(2,1fr);} .el-col-12{width:100%!important;margin-bottom:1rem;} }
</style>
