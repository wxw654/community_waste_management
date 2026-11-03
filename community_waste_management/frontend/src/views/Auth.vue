<template>
  <div class="auth-container">
    <div class="auth-background">
      <div class="floating-shape shape-1"></div>
      <div class="floating-shape shape-2"></div>
      <div class="floating-shape shape-3"></div>
    </div>
    
    <div class="auth-card">
      <div class="card-header">
        <div class="logo">
          <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z" fill="currentColor"/>
          </svg>
        </div>
        <h1>社区垃圾分类系统</h1>
        <p>共建绿色环保家园</p>
      </div>

      <div class="tab-container">
        <div class="tab-header">
          <button 
            :class="['tab-btn', { active: activeTab === 'login' }]" 
            @click="activeTab = 'login'"
          >用户登录</button>
          <button 
            :class="['tab-btn', { active: activeTab === 'register' }]" 
            @click="activeTab = 'register'"
          >居民注册</button>
          <button 
            :class="['tab-btn', { active: activeTab === 'admin' }]" 
            @click="activeTab = 'admin'"
          >管理员入口</button>
        </div>

        <div class="tab-content">
          <transition name="fade" mode="out-in">
            <div v-if="activeTab === 'login'" key="login" class="form-panel">
              <form @submit.prevent="handleLogin">
                <div class="input-group">
                  <svg class="input-icon" viewBox="0 0 24 24" fill="none">
                    <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" fill="currentColor"/>
                  </svg>
                  <input 
                    type="text" 
                    v-model="loginForm.username" 
                    placeholder="请输入用户名"
                    required
                  >
                </div>
                <div class="input-group">
                  <svg class="input-icon" viewBox="0 0 24 24" fill="none">
                    <path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z" fill="currentColor"/>
                  </svg>
                  <input 
                    type="password" 
                    v-model="loginForm.password" 
                    placeholder="请输入密码"
                    required
                  >
                </div>
                <button type="submit" class="btn-primary">
                  <span>登 录</span>
                  <svg viewBox="0 0 24 24" fill="none">
                    <path d="M12 4l-1.41 1.41L16.17 11H4v2h12.17l-5.58 5.59L12 20l8-8z" fill="currentColor"/>
                  </svg>
                </button>
                <div v-if="loginError" class="error-message">{{ loginError }}</div>
              </form>
            </div>

            <div v-else-if="activeTab === 'register'" key="register" class="form-panel">
              <form @submit.prevent="handleRegister">
                <div class="input-group">
                  <svg class="input-icon" viewBox="0 0 24 24" fill="none">
                    <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" fill="currentColor"/>
                  </svg>
                  <input 
                    type="text" 
                    v-model="registerForm.username" 
                    placeholder="请输入姓名"
                    required
                    :class="{ 'input-error': registerErrors.username }"
                    @blur="validateUsername"
                  >
                </div>
                <div v-if="registerErrors.username" class="field-error">{{ registerErrors.username }}</div>

                <div class="input-group">
                  <svg class="input-icon" viewBox="0 0 24 24" fill="none">
                    <path d="M6.62 10.79c1.44 2.83 3.76 5.14 6.59 6.59l2.2-2.2c.27-.27.67-.36 1.02-.24 1.12.37 2.33.57 3.57.57.55 0 1 .45 1 1V20c0 .55-.45 1-1 1-9.39 0-17-7.61-17-17 0-.55.45-1 1-1h3.5c.55 0 1 .45 1 1 0 1.25.2 2.45.57 3.57.11.35.03.74-.25 1.02l-2.2 2.2z" fill="currentColor"/>
                  </svg>
                  <input 
                    type="text" 
                    v-model="registerForm.phone_number" 
                    placeholder="请输入手机号码"
                    required
                    :class="{ 'input-error': registerErrors.phone_number }"
                    @blur="validatePhone"
                    maxlength="11"
                  >
                </div>
                <div v-if="registerErrors.phone_number" class="field-error">{{ registerErrors.phone_number }}</div>

                <div class="input-group">
                  <svg class="input-icon" viewBox="0 0 24 24" fill="none">
                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z" fill="currentColor"/>
                  </svg>
                  <select v-model="registerForm.role" required :class="{ 'input-error': registerErrors.role }">
                    <option value="">请选择您的身份</option>
                    <option value="resident">居民</option>
                    <option value="inspector">巡检员</option>
                    <option value="property">物业人员</option>
                  </select>
                </div>
                <div v-if="registerErrors.role" class="field-error">{{ registerErrors.role }}</div>

                <div class="input-group">
                  <svg class="input-icon" viewBox="0 0 24 24" fill="none">
                    <path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z" fill="currentColor"/>
                  </svg>
                  <input 
                    type="email" 
                    v-model="registerForm.email" 
                    placeholder="请输入邮箱地址"
                    required
                    :class="{ 'input-error': registerErrors.email }"
                    @blur="validateEmail"
                  >
                </div>
                <div v-if="registerErrors.email" class="field-error">{{ registerErrors.email }}</div>

                <div class="input-group">
                  <svg class="input-icon" viewBox="0 0 24 24" fill="none">
                    <path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z" fill="currentColor"/>
                  </svg>
                  <input 
                    type="password" 
                    v-model="registerForm.password" 
                    placeholder="请设置密码（至少6位）"
                    required
                    :class="{ 'input-error': registerErrors.password }"
                    @blur="validatePassword"
                    minlength="6"
                  >
                </div>
                <div v-if="registerErrors.password" class="field-error">{{ registerErrors.password }}</div>

                <div class="input-group">
                  <svg class="input-icon" viewBox="0 0 24 24" fill="none">
                    <path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z" fill="currentColor"/>
                  </svg>
                  <input 
                    type="password" 
                    v-model="registerForm.confirmPassword" 
                    placeholder="请再次输入密码"
                    required
                    :class="{ 'input-error': registerErrors.confirmPassword }"
                    @blur="validateConfirmPassword"
                    minlength="6"
                  >
                </div>
                <div v-if="registerErrors.confirmPassword" class="field-error">{{ registerErrors.confirmPassword }}</div>

                <button type="submit" class="btn-primary btn-register" :disabled="isRegistering">
                  <span v-if="isRegistering">注册中...</span>
                  <template v-else>
                    <span>立即注册</span>
                    <svg viewBox="0 0 24 24" fill="none">
                      <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z" fill="currentColor"/>
                    </svg>
                  </template>
                </button>
                <div v-if="registerError" class="error-message">{{ registerError }}</div>
                <div v-if="registerSuccess" class="success-message">{{ registerSuccess }}</div>
              </form>
            </div>

            <div v-else-if="activeTab === 'admin'" key="admin" class="form-panel">
              <div class="admin-notice">
                <svg viewBox="0 0 24 24" fill="none">
                  <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm0 10.99h7c-.53 4.12-3.28 7.79-7 8.94V12H5V6.3l7-3.11v8.8z" fill="currentColor"/>
                </svg>
                <p>管理员登录入口</p>
                <span>请使用管理员账号登录系统</span>
              </div>
              <form @submit.prevent="handleAdminLogin">
                <div class="input-group">
                  <svg class="input-icon" viewBox="0 0 24 24" fill="none">
                    <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" fill="currentColor"/>
                  </svg>
                  <input 
                    type="text" 
                    v-model="adminForm.username" 
                    placeholder="管理员账号"
                    required
                  >
                </div>
                <div class="input-group">
                  <svg class="input-icon" viewBox="0 0 24 24" fill="none">
                    <path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z" fill="currentColor"/>
                  </svg>
                  <input 
                    type="password" 
                    v-model="adminForm.password" 
                    placeholder="管理员密码"
                    required
                  >
                </div>
                <button type="submit" class="btn-primary btn-admin">
                  <span>管理员登录</span>
                  <svg viewBox="0 0 24 24" fill="none">
                    <path d="M12 4l-1.41 1.41L16.17 11H4v2h12.17l-5.58 5.59L12 20l8-8z" fill="currentColor"/>
                  </svg>
                </button>
                <div v-if="adminError" class="error-message">{{ adminError }}</div>
              </form>
            </div>
          </transition>
        </div>
      </div>

      <div class="card-footer">
        <p>© 2026 社区垃圾分类管理系统 · 共建美好家园</p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'Auth',
  data() {
    return {
      activeTab: 'login',
      loginForm: {
        username: '',
        password: ''
      },
      loginError: '',
      registerForm: {
        username: '',
        phone_number: '',
        role: '',
        email: '',
        password: '',
        confirmPassword: ''
      },
      registerErrors: {
        username: '',
        phone_number: '',
        role: '',
        email: '',
        password: '',
        confirmPassword: ''
      },
      registerError: '',
      registerSuccess: '',
      isRegistering: false,
      adminForm: {
        username: '',
        password: ''
      },
      adminError: ''
    }
  },
  methods: {
    async handleLogin() {
      try {
        console.log('[登录] 开始登录请求...', {
          url: '/api/auth/login/',
          method: 'POST',
          data: this.loginForm
        })

        const response = await axios.post('/api/auth/login/', this.loginForm)
        
        console.log('[登录] 登录成功！', response.data)

        localStorage.setItem('token', response.data.access)
        localStorage.setItem('user', JSON.stringify(response.data.user))
        this.$router.push('/profile')
      } catch (error) {
        console.error('[登录] 登录失败:', error)
        
        if (error.response) {
          console.error('[登录] 错误响应:', {
            status: error.response.status,
            data: error.response.data,
            headers: error.response.headers
          })
          
          if (error.response.data && error.response.data.error) {
            this.loginError = error.response.data.error
          } else if (error.response.status === 401) {
            this.loginError = '用户名或密码错误'
          } else if (error.response.status === 400) {
            this.loginError = '请求参数错误：' + JSON.stringify(error.response.data)
          } else {
            this.loginError = `服务器错误 (${error.response.status})`
          }
        } else if (error.request) {
          console.error('[登录] 无响应:', error.request)
          this.loginError = '网络连接失败，请检查网络后重试'
        } else {
          console.error('[登录] 请求配置错误:', error.message)
          this.loginError = '请求发送失败：' + error.message
        }
      }
    },

    validateUsername() {
      if (!this.registerForm.username || this.registerForm.username.trim() === '') {
        this.registerErrors.username = '请输入用户名'
        return false
      }
      if (this.registerForm.username.length < 2) {
        this.registerErrors.username = '用户名至少需要2个字符'
        return false
      }
      if (this.registerForm.username.length > 150) {
        this.registerErrors.username = '用户名不能超过150个字符'
        return false
      }
      this.registerErrors.username = ''
      return true
    },

    validatePhone() {
      const phoneRegex = /^1[3-9]\d{9}$/
      if (!this.registerForm.phone_number || this.registerForm.phone_number.trim() === '') {
        this.registerErrors.phone_number = '请输入手机号码'
        return false
      }
      if (!phoneRegex.test(this.registerForm.phone_number)) {
        this.registerErrors.phone_number = '手机号格式不正确，请输入11位有效手机号'
        return false
      }
      this.registerErrors.phone_number = ''
      return true
    },

    validateEmail() {
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
      if (!this.registerForm.email || this.registerForm.email.trim() === '') {
        this.registerErrors.email = '请输入邮箱地址'
        return false
      }
      if (!emailRegex.test(this.registerForm.email)) {
        this.registerErrors.email = '邮箱格式不正确'
        return false
      }
      this.registerErrors.email = ''
      return true
    },

    validatePassword() {
      if (!this.registerForm.password || this.registerForm.password.trim() === '') {
        this.registerErrors.password = '请设置密码'
        return false
      }
      if (this.registerForm.password.length < 6) {
        this.registerErrors.password = '密码至少需要6个字符'
        return false
      }
      this.registerErrors.password = ''
      return true
    },

    validateConfirmPassword() {
      if (!this.registerForm.confirmPassword || this.registerForm.confirmPassword.trim() === '') {
        this.registerErrors.confirmPassword = '请再次输入密码'
        return false
      }
      if (this.registerForm.confirmPassword !== this.registerForm.password) {
        this.registerErrors.confirmPassword = '两次输入的密码不一致'
        return false
      }
      this.registerErrors.confirmPassword = ''
      return true
    },

    validateAllFields() {
      let isValid = true
      
      isValid = this.validateUsername() && isValid
      isValid = this.validatePhone() && isValid
      isValid = this.validateEmail() && isValid
      isValid = this.validatePassword() && isValid
      isValid = this.validateConfirmPassword() && isValid
      
      if (!this.registerForm.role) {
        this.registerErrors.role = '请选择您的身份'
        isValid = false
      } else {
        this.registerErrors.role = ''
      }

      return isValid
    },

    async handleRegister() {
      this.registerError = ''
      this.registerSuccess = ''

      console.log('[注册] 开始表单验证...')
      
      if (!this.validateAllFields()) {
        console.warn('[注册] 表单验证失败:', this.registerErrors)
        this.registerError = '请检查表单中的错误信息'
        return
      }

      console.log('[注册] 表单验证通过，准备提交数据:', {
        ...this.registerForm,
        password: '******',
        confirmPassword: '******'
      })

      this.isRegistering = true

      try {
        const requestData = {
          username: this.registerForm.username,
          phone_number: this.registerForm.phone_number,
          role: this.registerForm.role,
          email: this.registerForm.email,
          password: this.registerForm.password
        }

        console.log('[注册] 发送注册请求...', {
          url: '/api/auth/register/',
          method: 'POST',
          data: requestData
        })

        const response = await axios.post('/api/auth/register/', requestData)

        console.log('[注册] 注册成功！', response.data)

        this.registerSuccess = '注册成功！正在跳转到个人中心...'
        
        localStorage.setItem('token', response.data.access)
        localStorage.setItem('user', JSON.stringify(response.data.user))

        setTimeout(() => {
          this.$router.push('/profile')
        }, 1500)

      } catch (error) {
        console.error('[注册] 注册失败！详细错误信息:')
        console.error('- 错误对象:', error)
        
        if (error.response) {
          console.error('- 响应状态码:', error.response.status)
          console.error('- 响应数据:', error.response.data)
          console.error('- 响应头:', error.response.headers)
          console.error('- 完整响应:', error.response)

          if (error.response.status === 400) {
            const errors = error.response.data
            console.error('- 字段错误详情:', errors)
            
            if (typeof errors === 'object' && !Array.isArray(errors)) {
              const errorMessages = []
              
              for (const [field, messages] of Object.entries(errors)) {
                console.error(`  字段 "${field}" 错误:`, messages)
                
                if (Array.isArray(messages)) {
                  errorMessages.push(messages.join('; '))
                  
                  if (field === 'username') {
                    if (messages.some(m => m.includes('已存在') || m.includes('unique'))) {
                      this.registerErrors.username = '该用户名已被注册'
                    } else {
                      this.registerErrors.username = messages[0]
                    }
                  } else if (field === 'phone_number') {
                    this.registerErrors.phone_number = messages[0]
                  } else if (field === 'email') {
                    if (messages.some(m => m.includes('已存在') || m.includes('unique'))) {
                      this.registerErrors.email = '该邮箱已被注册'
                    } else {
                      this.registerErrors.email = messages[0]
                    }
                  } else if (field === 'password') {
                    this.registerErrors.password = messages[0]
                  }
                } else if (typeof messages === 'string') {
                  errorMessages.push(messages)
                }
              }
              
              if (errorMessages.length > 0) {
                this.registerError = errorMessages.join('; ')
              } else {
                this.registerError = '注册信息填写有误，请检查后重试'
              }
            } else if (errors.error) {
              this.registerError = errors.error
            } else {
              this.registerError = '注册信息验证失败：' + JSON.stringify(errors)
            }
            
          } else if (error.response.status === 401) {
            this.registerError = '未授权访问'
          } else if (error.response.status === 403) {
            this.registerError = '注册功能暂时不可用'
          } else if (error.response.status >= 500) {
            this.registerError = '服务器内部错误，请稍后重试'
          } else {
            this.registerError = `注册失败 (${error.response.status}): ${JSON.stringify(error.response.data)}`
          }
          
        } else if (error.request) {
          console.error('- 无响应（可能是网络问题）:', error.request)
          this.registerError = '网络连接失败，请检查：\n1. 网络连接是否正常\n2. 后端服务是否启动（端口8000）\n3. 是否存在跨域(CORS)问题'
        } else {
          console.error('- 请求配置错误:', error.message)
          this.registerError = '请求发送失败：' + error.message
        }

        console.error('[注册] 最终显示的错误信息:', this.registerError)

      } finally {
        this.isRegistering = false
      }
    },
    
    async handleAdminLogin() {
      try {
        console.log('[管理员登录] 开始登录请求...')

        const mockUser = {
          id: 0,
          username: this.adminForm.username || '管理员',
          role: 'admin',
          points: 0
        }
        const mockToken = 'admin-token-' + Date.now()
        
        console.log('[管理员登录] 使用模拟登录')

        localStorage.setItem('token', mockToken)
        localStorage.setItem('user', JSON.stringify(mockUser))
        this.$router.push('/dashboard')
      } catch (error) {
        console.error('[管理员登录] 失败:', error)
        this.adminError = '管理员登录失败'
      }
    }
  }
}
</script>

<style scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

.auth-container {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: linear-gradient(135deg, #11998e 0%, #38ef7d 50%, #56ab2f 100%);
  position: relative;
  overflow: hidden;
  padding: 20px;
}

.auth-background {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  overflow: hidden;
  z-index: 0;
}

.floating-shape {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  animation: float 20s infinite ease-in-out;
}

.shape-1 {
  width: 400px;
  height: 400px;
  top: -100px;
  left: -100px;
  animation-delay: 0s;
}

.shape-2 {
  width: 300px;
  height: 300px;
  bottom: -50px;
  right: -50px;
  animation-delay: -5s;
}

.shape-3 {
  width: 200px;
  height: 200px;
  top: 50%;
  left: 50%;
  animation-delay: -10s;
}

@keyframes float {
  0%, 100% {
    transform: translate(0, 0) rotate(0deg);
  }
  25% {
    transform: translate(50px, 50px) rotate(90deg);
  }
  50% {
    transform: translate(0, 100px) rotate(180deg);
  }
  75% {
    transform: translate(-50px, 50px) rotate(270deg);
  }
}

.auth-card {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  border-radius: 24px;
  box-shadow: 
    0 25px 50px -12px rgba(0, 0, 0, 0.25),
    0 0 0 1px rgba(255, 255, 255, 0.1);
  width: 100%;
  max-width: 500px;
  position: relative;
  z-index: 1;
  overflow: hidden;
}

.card-header {
  text-align: center;
  padding: 40px 40px 30px;
  background: linear-gradient(180deg, rgba(17, 153, 142, 0.05) 0%, transparent 100%);
}

.logo {
  width: 70px;
  height: 70px;
  background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 20px;
  box-shadow: 0 10px 30px rgba(17, 153, 142, 0.3);
}

.logo svg {
  width: 40px;
  height: 40px;
  color: white;
}

.card-header h1 {
  font-size: 1.6rem;
  color: #1a1a2e;
  font-weight: 700;
  margin-bottom: 8px;
  letter-spacing: 0.5px;
}

.card-header p {
  color: #666;
  font-size: 0.95rem;
}

.tab-container {
  padding: 0 40px;
}

.tab-header {
  display: flex;
  background: #f5f7fa;
  border-radius: 12px;
  padding: 4px;
  margin-bottom: 30px;
}

.tab-btn {
  flex: 1;
  padding: 12px 16px;
  border: none;
  background: transparent;
  border-radius: 10px;
  font-size: 0.9rem;
  font-weight: 500;
  color: #666;
  cursor: pointer;
  transition: all 0.3s ease;
}

.tab-btn:hover {
  color: #11998e;
}

.tab-btn.active {
  background: white;
  color: #11998e;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  font-weight: 600;
}

.tab-content {
  min-height: auto;
}

.form-panel {
  animation: slideIn 0.3s ease;
}

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateX(10px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.input-group {
  position: relative;
  margin-bottom: 20px;
}

.input-icon {
  position: absolute;
  left: 16px;
  top: 50%;
  transform: translateY(-50%);
  width: 20px;
  height: 20px;
  color: #aaa;
  transition: color 0.3s ease;
  z-index: 1;
}

.input-group input,
.input-group select {
  width: 100%;
  padding: 16px 16px 16px 50px;
  border: 2px solid #e8e8e8;
  border-radius: 12px;
  font-size: 0.95rem;
  color: #333;
  background: #fafafa;
  transition: all 0.3s ease;
  appearance: none;
}

.input-group input:focus,
.input-group select:focus {
  outline: none;
  border-color: #11998e;
  background: white;
  box-shadow: 0 0 0 4px rgba(17, 153, 142, 0.1);
}

.input-group input.input-error,
.input-group select.input-error {
  border-color: #f56565;
  background: #fff5f5;
}

.input-group input.input-error:focus,
.input-group select.input-error:focus {
  border-color: #f56565;
  box-shadow: 0 0 0 4px rgba(245, 101, 101, 0.1);
}

.input-group input::placeholder {
  color: #aaa;
}

.input-group select {
  cursor: pointer;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23aaa' d='M6 8L1 3h10z'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
}

.field-error {
  color: #f56565;
  font-size: 0.85rem;
  margin-top: -12px;
  margin-bottom: 8px;
  padding-left: 4px;
}

.btn-primary {
  width: 100%;
  padding: 16px;
  border: none;
  border-radius: 12px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
  color: white;
  box-shadow: 0 4px 15px rgba(17, 153, 142, 0.4);
  transition: all 0.3s ease;
  margin-top: 10px;
}

.btn-primary:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(17, 153, 142, 0.5);
}

.btn-primary:active:not(:disabled) {
  transform: translateY(0);
}

.btn-primary:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.btn-primary svg {
  width: 20px;
  height: 20px;
}

.btn-register {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
}

.btn-register:hover:not(:disabled) {
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
}

.btn-admin {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
  box-shadow: 0 4px 15px rgba(245, 87, 108, 0.4);
}

.btn-admin:hover {
  box-shadow: 0 8px 25px rgba(245, 87, 108, 0.5);
}

.admin-notice {
  text-align: center;
  padding: 20px;
  background: linear-gradient(135deg, rgba(240, 147, 251, 0.1) 0%, rgba(245, 87, 108, 0.1) 100%);
  border-radius: 12px;
  margin-bottom: 24px;
}

.admin-notice svg {
  width: 40px;
  height: 40px;
  color: #f5576c;
  margin-bottom: 12px;
}

.admin-notice p {
  font-size: 1rem;
  font-weight: 600;
  color: #333;
  margin-bottom: 4px;
}

.admin-notice span {
  font-size: 0.85rem;
  color: #888;
}

.error-message {
  margin-top: 16px;
  padding: 12px 16px;
  background: linear-gradient(135deg, #fff5f5 0%, #fed7d7 100%);
  border-radius: 10px;
  color: #c53030;
  font-size: 0.9rem;
  text-align: center;
  border-left: 4px solid #f56565;
  line-height: 1.5;
  white-space: pre-line;
}

.success-message {
  margin-top: 16px;
  padding: 12px 16px;
  background: linear-gradient(135deg, #f0fff4 0%, #c6f6d5 100%);
  border-radius: 10px;
  color: #22543d;
  font-size: 0.9rem;
  text-align: center;
  border-left: 4px solid #48bb78;
  font-weight: 500;
}

.card-footer {
  text-align: center;
  padding: 24px 40px 30px;
  border-top: 1px solid #f0f0f0;
  margin-top: 20px;
}

.card-footer p {
  color: #999;
  font-size: 0.85rem;
}

@media (max-width: 480px) {
  .auth-card {
    border-radius: 20px;
    max-width: 100%;
  }
  
  .card-header {
    padding: 30px 24px 20px;
  }
  
  .tab-container {
    padding: 0 24px;
  }
  
  .tab-header {
    flex-wrap: wrap;
    gap: 4px;
  }
  
  .tab-btn {
    font-size: 0.8rem;
    padding: 10px 8px;
  }
  
  .card-footer {
    padding: 20px 24px;
  }
}
</style>
