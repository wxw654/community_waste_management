<template>
  <div class="activities">
    <el-tabs v-model="activeTab" @tab-click="handleTabClick" class="activities-tabs">
      <el-tab-pane label="活动中心" name="list">
        <div class="page-header">
          <h2>社区活动中心</h2>
        </div>

        <el-card class="filter-card">
          <el-form :inline="true" :model="form" label-width="100px">
            <el-form-item label="活动状态">
              <el-select
                v-model="form.status"
                placeholder="选择状态"
                clearable
                @change="handleStatusChange"
                style="width: 180px"
              >
                <el-option label="全部" value=""></el-option>
                <el-option label="进行中" value="active"></el-option>
                <el-option label="已结束" value="ended"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="filterActivities">筛选</el-button>
              <el-button @click="resetFilter">重置</el-button>
            </el-form-item>
          </el-form>
        </el-card>

        <div class="activities-grid" v-loading="loadingActivities">
          <el-card
            v-for="activity in filteredActivities"
            :key="activity.id"
            class="activity-card"
            shadow="hover"
          >
            <template #header>
              <div class="card-header">
                <span>{{ activity.title }}</span>
                <el-tag :type="isActivityActive(activity) ? 'success' : 'info'" effect="dark">
                  {{ isActivityActive(activity) ? '进行中' : '已结束' }}
                </el-tag>
              </div>
            </template>
            <div class="activity-content">
              <div class="activity-image">
                <img :src="'https://picsum.photos/seed/' + activity.id + '/400/250'" :alt="activity.title" />
              </div>
              <div class="activity-info">
                <p class="activity-description">{{ activity.description }}</p>
                <div class="activity-meta">
                  <div class="meta-item">
                    <span>📅 时间：</span>{{ formatDate(activity.start_date) }} 至 {{ formatDate(activity.end_date) }}
                  </div>
                  <div class="meta-item">
                    <span>🎁 奖励：</span><strong style="color: #f56c6c;">{{ activity.reward_points }}</strong> 积分
                  </div>
                </div>
                <div class="action-buttons">
                  <el-button type="primary" size="small" @click="viewActivityDetail(activity)">
                    查看详情
                  </el-button>
                  <el-button
                    :type="activity.joined ? '' : 'success'"
                    size="small"
                    @click="joinActivity(activity)"
                    :disabled="!isActivityActive(activity)"
                  >
                    {{ activity.joined ? '已报名' : '立即报名' }}
                  </el-button>
                </div>
              </div>
            </div>
          </el-card>
        </div>

        <el-empty v-if="filteredActivities.length === 0 && !loadingActivities" description="暂无符合条件的活动"></el-empty>
      </el-tab-pane>

      <el-tab-pane label="活动详情" name="detail">
        <div class="page-header">
          <h2 v-if="selectedActivity">{{ selectedActivity.title }} - 活动详情</h2>
          <h2 v-else>请从活动列表中选择一个活动查看详情</h2>
        </div>

        <div v-if="selectedActivity" class="detail-content">
          <el-card class="detail-card">
            <div class="activity-banner">
              <img :src="'https://picsum.photos/seed/' + selectedActivity.id + '/800/300'" :alt="selectedActivity.title" />
              <div class="banner-overlay">
                <h3>{{ selectedActivity.title }}</h3>
                <el-tag :type="isActivityActive(selectedActivity) ? 'success' : 'info'" effect="dark" size="large">
                  {{ isActivityActive(selectedActivity) ? '进行中' : '已结束' }}
                </el-tag>
              </div>
            </div>

            <el-row :gutter="30" style="margin-top: 1.5rem;">
              <el-col :span="12">
                <el-descriptions title="📋 活动信息" :column="1" border>
                  <el-descriptions-item label="开始时间">{{ formatDate(selectedActivity.start_date) }}</el-descriptions-item>
                  <el-descriptions-item label="结束时间">{{ formatDate(selectedActivity.end_date) }}</el-descriptions-item>
                  <el-descriptions-item label="活动奖励">
                    <span style="color: #f56c6c; font-weight: bold;">{{ selectedActivity.reward_points }} 积分</span>
                  </el-descriptions-item>
                </el-descriptions>
              </el-col>
              <el-col :span="12">
                <el-card class="desc-card">
                  <template #header><span>📝 活动介绍</span></template>
                  <p>{{ selectedActivity.description }}</p>
                  <p style="margin-top: 1rem; color: #666; line-height: 1.8;">
                    这是一项非常有意义的社区环保活动，欢迎各位居民积极参与，共同为建设美好家园贡献力量。参与活动不仅能学习到实用的垃圾分类知识，还能获得丰厚的积分奖励！
                  </p>
                </el-card>
              </el-col>
            </el-row>

            <el-divider></el-divider>

            <div class="detail-actions">
              <el-button
                type="primary"
                size="large"
                @click="goToRegister(selectedActivity)"
                :disabled="!isActivityActive(selectedActivity) || selectedActivity.joined"
              >
                {{ selectedActivity.joined ? '✅ 您已报名此活动' : '🎉 立即报名参加' }}
              </el-button>
              <el-button size="large" @click="goBackToList">返回活动列表</el-button>
            </div>
          </el-card>
        </div>

        <el-empty v-else description="请从活动中心中选择一个活动查看详情"></el-empty>
      </el-tab-pane>

      <el-tab-pane label="活动报名" name="register">
        <div class="page-header">
          <h2 v-if="registeringActivity">报名参加：{{ registeringActivity.title }}</h2>
          <h2 v-else>请先选择要报名的活动</h2>
        </div>

        <div v-if="registeringActivity" class="register-content">
          <el-card class="register-card">
            <el-alert
              :title="`确认报名「${registeringActivity.title}」`"
              type="info"
              :closable="false"
              show-icon
              style="margin-bottom: 1.5rem;"
            >
              <template #default>
                <p>活动时间：{{ formatDate(registeringActivity.start_date) }} 至 {{ formatDate(registeringActivity.end_date) }}</p>
                <p>活动奖励：<strong style="color: #f56c6c;">{{ registeringActivity.reward_points }} 积分</strong></p>
              </template>
            </el-alert>

            <el-form ref="registerFormRef" :model="registerForm" :rules="registerRules" label-width="100px">
              <el-form-item label="真实姓名" prop="name">
                <el-input v-model="registerForm.name" placeholder="请输入您的真实姓名"></el-input>
              </el-form-item>
              <el-form-item label="联系电话" prop="phone">
                <el-input v-model="registerForm.phone" placeholder="请输入您的联系电话"></el-input>
              </el-form-item>
              <el-form-item label="参与人数" prop="count">
                <el-input-number v-model="registerForm.count" :min="1" :max="5" style="width: 200px;"></el-input-number>
              </el-form-item>
              <el-form-item label="备注说明">
                <el-input
                  v-model="registerForm.remark"
                  type="textarea"
                  :rows="3"
                  placeholder="如有特殊需求或疑问，请在此说明（可选）"
                ></el-input>
              </el-form-item>
              <el-form-item>
                <el-checkbox v-model="registerForm.agree">我已阅读并同意活动规则和注意事项</el-checkbox>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" size="large" @click="submitRegistration" :loading="submitting">
                  提交报名
                </el-button>
                <el-button size="large" @click="cancelRegister">取消</el-button>
              </el-form-item>
            </el-form>
          </el-card>
        </div>

        <el-empty v-else description='请先在"活动详情"中点击"立即报名"按钮'></el-empty>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { ElMessage, ElMessageBox } from 'element-plus'
import axios from 'axios'

export default {
  name: 'Activities',
  data() {
    return {
      activeTab: 'list',
      form: {
        status: ''
      },
      loadingActivities: false,
      submitting: false,
      selectedActivity: null,
      registeringActivity: null,
      registerForm: {
        name: '',
        phone: '',
        count: 1,
        remark: '',
        agree: false
      },
      registerRules: {
        name: [{ required: true, message: '请输入真实姓名', trigger: 'blur' }],
        phone: [
          { required: true, message: '请输入联系电话', trigger: 'blur' },
          { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号码', trigger: 'blur' }
        ],
        count: [{ required: true, message: '请选择参与人数', trigger: 'change' }]
      },
      allActivitiesData: []
    }
  },

  computed: {
    filteredActivities() {
      if (!this.form.status) {
        return this.allActivitiesData
      }

      const now = new Date()
      return this.allActivitiesData.filter(a => {
        if (this.form.status === 'active') {
          const endDate = new Date(a.end_date)
          return endDate >= now
        } else if (this.form.status === 'ended') {
          const endDate = new Date(a.end_date)
          return endDate < now
        }
        return true
      })
    }
  },

  mounted() {
    this.loadActivities()
  },

  methods: {
    async loadActivities() {
      this.loadingActivities = true
      try {
        const res = await axios.get('/api/activities/')
        this.allActivitiesData = res.data.results || res.data || []
      } catch (error) {
        console.error('加载活动失败:', error)
        ElMessage.error('加载活动失败')
      } finally {
        this.loadingActivities = false
      }
    },

    isActivityActive(activity) {
      const now = new Date()
      const endDate = new Date(activity.end_date)
      return endDate >= now
    },

    formatDate(dateStr) {
      if (!dateStr) return ''
      return dateStr.substring(0, 16).replace('T', ' ')
    },

    handleTabClick(tab) {
      this.activeTab = tab.props.name
    },

    filterActivities() {
      ElMessage.success(`筛选完成，共找到 ${this.filteredActivities.length} 个活动`)
    },

    resetFilter() {
      this.form.status = ''
      ElMessage.info('已重置筛选条件')
    },

    handleStatusChange(value) {
      this.form.status = value || ''
    },

    viewActivityDetail(activity) {
      this.selectedActivity = activity
      this.activeTab = 'detail'
    },

    goBackToList() {
      this.selectedActivity = null
      this.activeTab = 'list'
    },

    joinActivity(activity) {
      if (!this.isActivityActive(activity)) {
        ElMessage.error('该活动已结束，无法报名')
        return
      }
      if (activity.joined) {
        ElMessage.info('您已经报名了该活动')
        return
      }

      this.registeringActivity = activity
      this.registerForm = {
        name: '',
        phone: '',
        count: 1,
        remark: '',
        agree: false
      }
      this.activeTab = 'register'
    },

    goToRegister(activity) {
      this.joinActivity(activity)
    },

    cancelRegister() {
      this.registeringActivity = null
      this.activeTab = this.selectedActivity ? 'detail' : 'list'
    },

    submitRegistration() {
      if (!this.registerForm.agree) {
        ElMessage.warning('请先同意活动规则')
        return
      }

      this.submitting = true

      setTimeout(() => {
        this.registeringActivity.joined = true

        ElMessage.success('报名成功！祝您活动愉快')

        this.submitting = false
        this.registeringActivity = null
        this.selectedActivity = null
        this.activeTab = 'list'
      }, 800)
    }
  }
}
</script>

<style scoped>
.activities {
  padding: 1rem;
}

.activities-tabs {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.1);
}

.page-header h2 {
  font-size: 1.5rem;
  font-weight: bold;
  color: #333;
  margin-bottom: 1.5rem;
}

.filter-card {
  margin-bottom: 1.5rem;
}

.activities-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(450px, 1fr));
  gap: 1.5rem;
}

.activity-card {
  transition: all 0.3s ease;
}

.activity-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 25px rgba(0,0,0,0.15);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
}

.activity-content {
  padding: 0.5rem 0;
}

.activity-image {
  width: 100%;
  height: 180px;
  margin-bottom: 1rem;
  border-radius: 8px;
  overflow: hidden;
}

.activity-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.activity-description {
  color: #666;
  font-size: 0.9rem;
  line-height: 1.5;
  margin-bottom: 1rem;
}

.activity-meta {
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
  margin-bottom: 1rem;
  padding: 0.8rem;
  background: #f5f7fa;
  border-radius: 6px;
}

.meta-item {
  font-size: 0.85rem;
  color: #606266;
}

.action-buttons {
  display: flex;
  gap: 0.5rem;
}

.detail-content {
  animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

.detail-card {
  max-width: 1000px;
  margin: 0 auto;
}

.activity-banner {
  position: relative;
  height: 280px;
  border-radius: 12px;
  overflow: hidden;
}

.activity-banner img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.banner-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 1.5rem;
  background: linear-gradient(transparent, rgba(0,0,0,0.7));
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
}

.banner-overlay h3 {
  margin: 0;
  font-size: 1.5rem;
}

.desc-card {
  height: 100%;
}

.desc-card p {
  color: #666;
  line-height: 1.8;
}

.detail-actions {
  text-align: center;
  padding-top: 1rem;
}

.detail-actions .el-button {
  min-width: 160px;
}

.register-content {
  animation: fadeIn 0.3s ease;
}

.register-card {
  max-width: 600px;
  margin: 0 auto;
}

@media screen and (max-width: 768px) {
  .activities-grid {
    grid-template-columns: 1fr;
  }

  .el-col-12 {
    width: 100% !important;
    margin-bottom: 1rem;
  }

  .detail-actions {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .detail-actions .el-button {
    width: 100%;
  }
}
</style>
