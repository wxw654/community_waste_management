<template>
  <div class="products">
    <el-tabs v-model="activeTab" @tab-click="handleTabClick" class="products-tabs">
      <el-tab-pane label="积分商城" name="mall">
        <div class="page-header"><h2>积分商城</h2><el-tag type="warning" size="large" effect="dark">💰 我的积分：{{ userPoints }}</el-tag></div>
        <el-card class="filter-card">
          <el-form :inline="true" :model="form" label-width="100px">
            <el-form-item label="商品类别">
              <el-select v-model="form.category" placeholder="选择类别" clearable @change="handleCatChange" style="width:180px">
                <el-option label="全部" value=""></el-option><el-option label="生活用品" value="daily"></el-option><el-option label="家居用品" value="home"></el-option><el-option label="食品饮料" value="food"></el-option><el-option label="其他" value="other"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="积分范围">
              <el-select v-model="form.pointsRange" placeholder="选择范围" clearable @change="handleRangeChange" style="width:180px">
                <el-option label="全部" value=""></el-option><el-option label="0-100" value="0-100"></el-option><el-option label="100-500" value="100-500"></el-option><el-option label="500+" value="500+"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item><el-button type="primary" @click="filterProducts">筛选</el-button><el-button @click="resetFilter">重置</el-button></el-form-item>
          </el-form>
        </el-card>
        <div class="products-grid" v-loading="loadingProducts">
          <el-card v-for="p in filteredProducts" :key="p.id" shadow="hover" style="cursor:pointer;" @click="viewProduct(p)">
            <template #header><span>{{ p.name }}<el-tag type="danger" size="small" effect="dark" v-if="p.stock<10">库存紧张</el-tag></span></template>
            <img :src="p.image_url || 'https://picsum.photos/seed/' + p.id + '/300/250'" :alt="p.name" style="width:100%;height:150px;object-fit:cover;border-radius:8px;margin-bottom:.5rem;">
            <p style="color:#666;font-size:.9rem;margin-bottom:.8rem;">{{ p.description }}</p>
            <div style="display:flex;justify-content:space-between;">
              <span style="color:#f56c6c;font-weight:bold;">{{ p.points_required }} 积分</span>
              <span style="color:#999;font-size:.85rem;">库存:{{ p.stock }}</span>
            </div>
            <div style="margin-top:.8rem;"><el-button type="primary" size="small" @click.stop="viewProduct(p)">查看详情</el-button><el-button type="success" size="small" @click.stop="exchange(p)" :disabled="userPoints<p.points_required||p.stock<=0">兑换</el-button></div>
          </el-card>
        </div>
      </el-tab-pane>

      <el-tab-pane label="商品详情" name="detail">
        <div class="page-header"><h2 v-if="selectedProduct">{{ selectedProduct.name }} - 商品详情</h2><h2 v-else>请选择商品</h2></div>
        <div v-if="selectedProduct">
          <el-row :gutter="30">
            <el-col :span="10"><img :src="selectedProduct.image_url || 'https://picsum.photos/seed/' + selectedProduct.id + '/400/300'" alt="" style="width:100%;border-radius:12px;"></el-col>
            <el-col :span="14">
              <h3>{{ selectedProduct.name }}</h3><el-divider/>
              <p style="font-size:1.6rem;color:#f56c6c;font-weight:bold;">{{ selectedProduct.points_required }} 积分</p>
              <p>库存：<el-tag :type="selectedProduct.stock>10?'success':'danger'">{{ selectedProduct.stock }} 件</el-tag></p>
              <p>创建时间：{{ selectedProduct.created_at ? selectedProduct.created_at.substring(0, 10) : '' }}</p>
              <el-divider/><p>{{ selectedProduct.description }}</p>
              <div style="margin-top:1.5rem;display:flex;align-items:center;gap:1rem;">
                <el-input-number v-model="qty" :min="1" :max="selectedProduct.stock"></el-input-number>
                <span>总计：<strong style="color:#f56c6c;">{{ selectedProduct.points_required*qty }}</strong> 积分</span>
              </div>
              <div style="margin-top:1.5rem;"><el-button type="primary" size="large" @click="confirmExchange(selectedProduct)" :disabled="userPoints<selectedProduct.points_required*qty">确认兑换</el-button><el-button size="large" @click="goBackMall">返回商城</el-button></div>
            </el-col>
          </el-row>
        </div>
        <el-empty v-else description="请从商城中选择商品"></el-empty>
      </el-tab-pane>

      <el-tab-pane label="兑换订单" name="orders">
        <div class="page-header"><h2>我的兑换订单</h2></div>
        <el-card>
          <template #header>
            <div style="display:flex;justify-content:space-between;align-items:center;">
              <span>订单列表（共 {{ orders.length }} 条）</span>
              <el-radio-group v-model="orderFilter" size="small" @change="handleOrderFilter">
                <el-radio-button label="all">全部</el-radio-button><el-radio-button label="pending">待领取</el-radio-button><el-radio-button label="completed">已完成</el-radio-button>
              </el-radio-group>
            </div>
          </template>
          <el-table :data="filteredOrders" stripe v-loading="loadingOrders" style="width:100%">
            <el-table-column prop="id" label="订单号" width="120"><template #default="scope"><strong>#{{ String(scope.row.id).padStart(6,'0') }}</strong></template></el-table-column>
            <el-table-column prop="product.name" label="商品名称" width="180"></el-table-column>
            <el-table-column prop="total_points" label="消耗积分" width="120"><template #default="scope"><span style="color:#f56c6c;">-{{ scope.row.total_points }}</span></template></el-table-column>
            <el-table-column prop="status" label="状态" width="120"><template #default="scope"><el-tag :type="scope.row.status==='pending'?'warning':'success'" effect="dark">{{ scope.row.status==='pending'?'待领取':'已完成' }}</el-tag></template></el-table-column>
            <el-table-column prop="created_at" label="下单时间" width="180"><template #default="scope">{{ formatDate(scope.row.created_at) }}</template></el-table-column>
            <el-table-column label="操作" width="120"><template #default="scope"><el-button v-if="scope.row.status==='pending'" size="small" type="warning" @click="cancelOrder(scope.row)">取消</el-button></template></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { ElMessage, ElMessageBox } from 'element-plus'
import axios from 'axios'

export default {
  name:'Products',
  data(){ return {
    activeTab:'mall', form:{category:'',pointsRange:''}, userPoints:1250, qty:1, orderFilter:'all', selectedProduct:null,
    loadingProducts:false,
    loadingOrders:false,
    allProductsData:[],
    orders:[]
  }},
  computed:{
    filteredProducts(){
      let r=[...this.allProductsData]
      if(this.form.category) r=r.filter(p=>p.category===this.form.category)
      if(this.form.pointsRange){ const[mx]=this.form.pointsRange.split('-'); if(mx==='+')r=r.filter(p=>p.points_required>=500); else{const[min,max]=this.form.points_range.split('-');r=r.filter(p=>p.points_required>=+min&&p.points_required<=+max)} }
      return r
    },
    filteredOrders(){ if(this.orderFilter==='all')return this.orders; return this.orders.filter(o=>o.status===this.orderFilter) }
  },
  mounted() {
    this.loadProducts()
    this.loadOrders()
  },
  methods:{
    handleTabClick(t){ this.activeTab=t.props.name },

    async loadProducts() {
      this.loadingProducts = true
      try {
        const res = await axios.get('/api/products/')
        this.allProductsData = res.data.results || res.data || []
      } catch (error) {
        console.error('加载商品失败:', error)
        ElMessage.error('加载商品失败')
      } finally {
        this.loadingProducts = false
      }
    },

    async loadOrders() {
      this.loadingOrders = true
      try {
        const res = await axios.get('/api/orders/')
        this.orders = res.data.results || res.data || []
      } catch (error) {
        console.error('加载订单失败:', error)
        ElMessage.error('加载订单失败')
      } finally {
        this.loadingOrders = false
      }
    },

    filterProducts(){ ElMessage.success(`筛选完成，${this.filteredProducts.length}件`) },
    resetFilter(){ this.form={category:'',pointsRange:''} },
    handleCatChange(v){ this.form.category=v||'' }, handleRangeChange(v){ this.form.pointsRange=v||'' },
    viewProduct(p){ this.selectedProduct=p; this.qty=1; this.activeTab='detail' },
    goBackMall(){ this.selectedProduct=null; this.activeTab='mall' },
    getCatName(c){ return{daily:'生活用品',home:'家居用品',food:'食品饮料',other:'其他'}[c]||c },

    formatDate(dateStr) {
      if (!dateStr) return ''
      return dateStr.substring(0, 16).replace('T', ' ')
    },

    exchange(p){
      ElMessageBox.confirm(`确定兑换「${p.name}」？消耗 ${p.points_required} 积分`,'确认',{type:'warning'}).then(()=>{
        this.userPoints-=p.points_required; p.stock--
        this.orders.unshift({id:Date.now(),product:p,total_points:p.points_required,status:'pending',created_at:new Date().toISOString()})
        ElMessage.success('兑换成功！')
      }).catch(()=>{})
    },
    confirmExchange(p){
      const total=p.points_required*this.qty
      if(this.userPoints<total){ ElMessage.error('积分不足'); return }
      ElMessageBox.confirm(`确定兑换${this.qty}件「${p.name}」？消耗${total}积分`,'确认',{type:'warning'}).then(()=>{
        this.userPoints-=total; p.stock-=this.qty
        this.orders.unshift({id:Date.now(),product:p,total_points:total,status:'pending',created_at:new Date().toISOString()})
        ElMessage.success(`成功！消耗${total}积分`); this.selectedProduct=null; this.activeTab='orders'
      }).catch(()=>{})
    },
    handleOrderFilter(s){ this.orderFilter=s },
    cancelOrder(o){ ElMessageBox.confirm('确定取消？','提示',{type:'warning'}).then(()=>{ o.status='cancelled'; this.userPoints+=o.total_points; ElMessage.success('已取消') }).catch(()=>{}) }
  }
}
</script>

<style scoped>
.products{padding:1rem;}
.products-tabs{background:white;border-radius:8px;box-shadow:0 2px 12px rgba(0,0,0,0.1);}
.page-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:1.5rem;}
.page-header h2{font-size:1.5rem;color:#333;}
.filter-card{margin-bottom:1.5rem;}
.products-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(320px,1fr));gap:1.5rem;margin-top:1rem;}
</style>
