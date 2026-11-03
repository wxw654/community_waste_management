<template>
  <div class="profile">
    <el-tabs v-model="activeTab" @tab-click="handleTabClick" class="profile-tabs">
      <el-tab-pane label="个人中心" name="center">
        <div class="page-header"><h2>个人中心</h2></div>
        <el-row :gutter="30">
          <el-col :span="8">
            <el-card text-align="center">
              <div style="padding:1.5rem 0;">
                <el-avatar :size="100" style="background:linear-gradient(135deg,#667eea,#764ba2);font-size:2.5rem;">{{ (user.username || '用户').charAt(0).toUpperCase() }}</el-avatar>
                <h3 style="margin:1rem 0 .5rem;">{{ user.username || '用户' }}</h3>
                <el-tag type="success">达人</el-tag>
              </div>
              <el-divider/>
              <div style="background:linear-gradient(135deg,#f093fb,#f5576c);border-radius:12px;padding:1.5rem;color:white;margin-bottom:1rem;">
                <div style="font-size:2.5rem;font-weight:bold;">{{ user.points }}</div>
                <div>当前积分</div>
              </div>
              <el-divider/>
              <div style="text-align:left;font-size:.9rem;color:#666;">
                <p>📧 {{ user.email }}</p><p>📱 {{ user.phone }}</p><p>👨‍👩‍👧 家庭：{{ user.family }}人</p><p>🏠 房屋：{{ houses.length }}套</p>
              </div>
            </el-card>
          </el-col>
          <el-col :span="16">
            <el-card><template #header><span>快捷功能</span></template>
              <el-row :gutter="15">
                <el-col :span="8" v-for="(item,i) in quickLinks" :key="i">
                  <div @click="handleQuick(item.action)" style="text-align:center;padding:1.5rem;background:#f8f9fa;border-radius:10px;cursor:pointer;margin-bottom:1rem;transition:all .3s;" @mouseenter="$event.currentTarget.style.transform='translateY(-3px)'" @mouseleave="$event.currentTarget.style.transform=''">
                    <div style="font-size:2rem;margin-bottom:.5rem;">{{ item.icon }}</div>
                    <div style="font-weight:500;color:#333;">{{ item.title }}</div>
                    <div style="color:#999;font-size:.85rem;margin-top:.3rem;">{{ item.desc }}</div>
                  </div>
                </el-col>
              </el-row>
            </el-card>

            <el-card style="margin-top:1.5rem;"><template #header><span>我的房屋（{{ houses.length }}套）</span></template>
              <div v-for="h in houses" :key="h.id" style="display:flex;align-items:center;gap:1rem;padding:.8rem 0;border-bottom:1px solid #f0f0f0;">
                <el-tag type="success" size="small">已认证</el-tag><span>{{ h.building }}-{{ h.unit }}-{{ h.room }}</span>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </el-tab-pane>

      <el-tab-pane label="积分记录" name="records">
        <div class="page-header"><h2>积分记录</h2></div>
        <el-card>
          <template #header>
            <div style="display:flex;justify-content:space-between;align-items:center;">
              <span>收支明细</span><span>当前总积分：<strong style="color:#f56c6c;font-size:1.2rem;">{{ user.points }}</strong></span>
            </div>
          </template>
          <el-table :data="pointsRecords" stripe style="width:100%">
            <el-table-column prop="date" label="时间" width="180"></el-table-column>
            <el-table-column prop="type" label="类型" width="100"><template #default="scope"><el-tag :type="scope.row.amount>0?'success':'danger'" size="small" effect="dark">{{ scope.row.amount>0?'获得':'消耗' }}</el-tag></template></el-table-column>
            <el-table-column prop="description" label="说明"></el-table-column>
            <el-table-column prop="amount" label="变动" width="120"><template #default="scope"><span :style="{color:scope.row.amount>0?'#67c23a':'#f56c6c',fontWeight:'bold'}">{{ scope.row.amount>0?'+':'' }}{{ scope.row.amount }}</span></template></el-table-column>
            <el-table-column prop="balance" label="余额" width="100"></el-table-column>
          </el-table>
          <div style="margin-top:1.5rem;display:flex;justify-content:flex-end;"><el-pagination v-model:current-page="currentPage" :page-size="10" :total="pointsRecords.length" layout="prev,pager,next"></el-pagination></div>
        </el-card>
      </el-tab-pane>

      <el-tab-pane label="房屋管理" name="houses">
        <div class="page-header"><h2>房屋管理</h2></div>
        <el-card>
          <template #header>
            <div style="display:flex;justify-content:space-between;align-items:center;">
              <span>我的房屋（共 {{ houses.length }} 套）</span>
              <el-button type="primary" @click="showAddDialog=true">+ 添加新房屋</el-button>
            </div>
          </template>
          <el-table :data="houses" stripe style="width:100%">
            <el-table-column prop="building" label="楼栋" width="100"></el-table-column>
            <el-table-column prop="unit" label="单元" width="80"></el-table-column>
            <el-table-column prop="room" label="房间号" width="100"></el-table-column>
            <el-table-column prop="area" label="面积(㎡)" width="100"></el-table-column>
            <el-table-column prop="status" label="状态" width="120"><template #default="scope"><el-tag :type="scope.row.is_verified?'success':'warning'" effect="dark">{{ scope.row.is_verified?'已认证':'待认证' }}</el-tag></template></el-table-column>
            <el-table-column prop="createdAt" label="添加时间" width="180"></el-table-column>
            <el-table-column label="操作" width="200"><template #default="scope">
              <el-button v-if="!scope.row.is_verified" size="small" type="warning" @click="verifyHouse(scope.row)">申请认证</el-button>
              <el-button size="small" type="danger" @click="deleteHouse(scope.row)">删除</el-button>
            </template></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
    </el-tabs>

    <el-dialog v-model="showEditDialog" title="编辑资料" width="500px">
      <el-form :model="editForm" label-width="90px">
        <el-form-item label="用户名"><el-input v-model="editForm.username" disabled></el-input></el-form-item>
        <el-form-item label="邮箱"><el-input v-model="editForm.email"></el-input></el-form-item>
        <el-form-item label="手机号"><el-input v-model="editForm.phone"></el-input></el-form-item>
        <el-form-item label="家庭成员"><el-input-number v-model="editForm.family" :min="1" :max="20"></el-input-number></el-form-item>
      </el-form>
      <template #footer><el-button @click="showEditDialog=false">取消</el-button><el-button type="primary" @click="saveProfile">保存</el-button></template>
    </el-dialog>

    <el-dialog v-model="showAddDialog" title="添加新房屋" width="500px">
      <el-form :model="newHouse" label-width="80px">
        <el-form-item label="楼栋"><el-select v-model="newHouse.building" placeholder="选择" style="width:100%"><el-option label="1号楼" value="1号楼"/><el-option label="2号楼" value="2号楼"/><el-option label="3号楼" value="3号楼"/><el-option label="4号楼" value="4号楼"/></el-select></el-form-item>
        <el-form-item label="单元"><el-select v-model="newHouse.unit" placeholder="选择" style="width:100%"><el-option label="1单元" value="1单元"/><el-option label="2单元" value="2单元"/><el-option label="3单元" value="3单元"/></el-select></el-form-item>
        <el-form-item label="房间号"><el-input v-model="newHouse.room" placeholder="如101"></el-input></el-form-item>
        <el-form-item label="面积"><el-input-number v-model="newHouse.area" :min="30" :max="300" style="width:100%"></el-input-number></el-form-item>
      </el-form>
      <template #footer><el-button @click="showAddDialog=false">取消</el-button><el-button type="primary" @click="addHouse">确认添加</el-button></template>
    </el-dialog>
  </div>
</template>

<script>
import { ElMessage, ElMessageBox } from 'element-plus'
export default {
  name:'Profile',
  data(){
    return {
      activeTab:'center', currentPage:1, showEditDialog:false, showAddDialog:false,
      user:{username:'用户',points:0,email:'',phone:'',family:1},
      editForm:{username:'',email:'',phone:'',family:1},
      newHouse:{building:'',unit:'',room:'',area:80},
      houses:[
        {id:1,building:'1号楼',unit:'1单元',room:'101',area:95,is_verified:true,createdAt:'2026-01-15'},
        {id:2,building:'1号楼',unit:'1单元',room:'102',area:88,is_verified:true,createdAt:'2026-02-20'}
      ],
      pointsRecords:[
        {date:'2026-04-05 08:30',type:'获得',description:'垃圾投放 - 可回收垃圾',amount:52,balance:1255},
        {date:'2026-04-03 18:45',type:'获得',description:'垃圾投放 - 厨余垃圾',amount:38,balance:1203},
        {date:'2026-04-01 14:20',type:'消耗',description:'兑换商品 - 洗衣液',amount:-200,balance:1165},
        {date:'2026-03-31 09:15',type:'获得',description:'垃圾投放 - 其他垃圾',amount:25,balance:1365},
        {date:'2026-03-28 17:00',type:'获得',description:'参与活动奖励',amount:300,balance:1340}
      ],
      quickLinks:[
        {icon:'📊',title:'投放记录',desc:'查看历史数据',action:'records'},
        {icon:'💰',title:'积分商城',desc:'兑换礼品',action:'products'},
        {icon:'🎉',title:'活动中心',desc:'参与活动',action:'activities'},
        {icon:'📍',title:'投放点查询',desc:'查找投放点',action:'points'},
        {icon:'📖',title:'分类指南',desc:'学习知识',action:'guides'},
        {icon:'✏️',title:'编辑资料',desc:'修改信息',action:'edit'}
      ]
    }
  },
  mounted(){
    const u=localStorage.getItem('user')
    if(u){
      try{
        const j=JSON.parse(u)
        this.user.username=j.username||'用户'
        this.user.points=j.points||0
        this.user.email=j.email||''
        this.user.phone=j.phone_number||j.phone||''
      }catch(e){}
    }
    this.editForm={username:this.user.username,email:this.user.email,phone:this.user.phone,family:this.user.family}
  },
  methods:{
    handleTabClick(t){ this.activeTab=t.props.name },
    handleQuick(a){
      const m={records:'/records',products:'/products',activities:'/activities',points:'/points',guides:'/guides'}
      if(m[a])this.$router.push(m[a])
      else if(a==='edit')this.showEditDialog=true
    },
    saveProfile(){
      this.user.email=this.editForm.email; this.user.phone=this.editForm.phone; this.user.family=this.editForm.family
      ElMessage.success('更新成功'); this.showEditDialog=false
    },
    addHouse(){
      this.houses.push({id:Date.now(),building:this.newHouse.building,unit:this.newHouse.unit,room:this.newHouse.room,area:this.newHouse.area,is_verified:false,createdAt:new Date().toLocaleDateString('zh-CN')})
      ElMessage.success('添加成功'); this.showAddDialog=false; this.newHouse={building:'',unit:'',room:'',area:80}
    },
    verifyHouse(h){ ElMessageBox.confirm(`认证「${h.building}-${h.unit}-${h.room}」?`,'提示',{confirmButtonText:'确定'}).then(()=>{ElMessage.success('已提交')}).catch(()=>{}) },
    deleteHouse(h){ ElMessageBox.confirm(`删除「${h.building}-${h.unit}-${h.room}」?`,'警告',{type:'warning'}).then(()=>{this.houses=this.houses.filter(x=>x.id!==h.id);ElMessage.success('已删除')}).catch(()=>{}) }
  }
}
</script>

<style scoped>
.profile{padding:1rem;}
.profile-tabs{background:white;border-radius:8px;box-shadow:0 2px 12px rgba(0,0,0,0.1);}
.page-header h2{font-size:1.5rem;color:#333;margin-bottom:1.5rem;}
</style>
