<template>
  <div class="app">
    <!-- 顶部绿色导航栏 -->
    <header class="top-header">
      <div class="header-left">
        <span class="header-logo">🧩</span>
        <h1>社区垃圾分类管理系统</h1>
      </div>
      <nav class="top-nav">
        <router-link to="/">首页</router-link>
        <router-link to="/login" v-if="!isLoggedIn">登录</router-link>
        <router-link to="/register" v-if="!isLoggedIn">注册</router-link>
        <router-link to="/points">投放点</router-link>
        <router-link to="/guides">分类指南</router-link>
        <router-link to="/products">积分商城</router-link>
        <router-link to="/activities">活动中心</router-link>
      </nav>
    </header>

    <!-- 主内容区 - 始终显示侧边栏 -->
    <div class="main-container">
      <!-- 左侧功能菜单 -->
      <aside class="sidebar">
        <div class="sidebar-header">
          <span class="logo-icon">🧩</span>
          <span class="logo-text">功能菜单</span>
        </div>
        <ul class="menu">
          <li :class="{ active: currentRoute === '/' || currentRoute === '' }">
            <router-link to="/">
              <span class="menu-icon">🏠</span>
              <span>首页</span>
            </router-link>
          </li>
          <li :class="{ active: currentRoute === '/profile' }">
            <router-link to="/profile">
              <span class="menu-icon">👤</span>
              <span>个人中心</span>
            </router-link>
          </li>
          <li :class="{ active: currentRoute === '/guides' }">
            <router-link to="/guides">
              <span class="menu-icon">📋</span>
              <span>分类指南</span>
            </router-link>
          </li>
          <li :class="{ active: currentRoute === '/points' }">
            <router-link to="/points">
              <span class="menu-icon">📍</span>
              <span>投放点查询</span>
            </router-link>
          </li>
          <li :class="{ active: currentRoute === '/records' }">
            <router-link to="/records">
              <span class="menu-icon">📝</span>
              <span>投放记录</span>
            </router-link>
          </li>
          <li :class="{ active: currentRoute === '/products' }">
            <router-link to="/products">
              <span class="menu-icon">🎁</span>
              <span>积分商城</span>
            </router-link>
          </li>
          <li :class="{ active: currentRoute === '/activities' }">
            <router-link to="/activities">
              <span class="menu-icon">🎉</span>
              <span>活动中心</span>
            </router-link>
          </li>
          <li :class="{ active: currentRoute === '/dashboard' }">
            <router-link to="/dashboard">
              <span class="menu-icon">📊</span>
              <span>数据可视化</span>
            </router-link>
          </li>
        </ul>

        <div class="sidebar-footer">
          <p>EcoWaste v2.0</p>
        </div>
      </aside>

      <!-- 右侧主内容区 -->
      <main class="content">
        <!-- 面包屑 -->
        <div class="breadcrumb">
          <el-breadcrumb separator="/">
            <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>{{ pageTitle }}</el-breadcrumb-item>
          </el-breadcrumb>
        </div>

        <!-- 页面内容 -->
        <router-view v-slot="{ Component }">
          <transition name="fade" mode="out-in">
            <component :is="Component" />
          </transition>
        </router-view>
      </main>
    </div>

    <!-- 底部版权 -->
    <footer class="footer">
      <p>&copy; 2026 Community Waste Management System. All Rights Reserved.</p>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'App',
  data() {
    return {
      currentRoute: ''
    }
  },
  computed: {
    isLoggedIn() {
      return localStorage.getItem('token') !== null
    },
    pageTitle() {
      const routeMap = {
        '/': '系统首页',
        '/profile': '个人中心',
        '/guides': '分类指南',
        '/points': '投放点查询',
        '/records': '垃圾投放记录',
        '/products': '积分商城',
        '/activities': '活动中心',
        '/dashboard': '数据可视化'
      }
      return routeMap[this.currentRoute] || '页面'
    }
  },
  watch: {
    $route: {
      handler(to) {
        this.currentRoute = to.path
      },
      immediate: true
    }
  }
}
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  line-height: 1.6;
  color: #333;
}

.app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

/* 顶部绿色导航栏 */
.top-header {
  background: #2e7d32;
  color: white;
  padding: 0 2rem;
  height: 56px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: sticky;
  top: 0;
  z-index: 999;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 0.6rem;
}

.header-logo {
  font-size: 1.4rem;
}

.top-header h1 {
  font-size: 1.3rem;
  font-weight: 600;
  letter-spacing: 1px;
}

.top-nav {
  display: flex;
  gap: 0.5rem;
  align-items: center;
}

.top-nav a {
  color: rgba(255,255,255,0.9);
  text-decoration: none;
  padding: 0.45rem 1rem;
  border-radius: 6px;
  transition: all 0.25s ease;
  font-size: 0.92rem;
}

.top-nav a:hover,
.top-nav a.router-link-active {
  background-color: rgba(255,255,255,0.18);
  color: white;
}

/* 主容器 */
.main-container {
  flex: 1;
  display: flex;
  min-height: calc(100vh - 56px - 44px);
}

/* 左侧菜单 */
.sidebar {
  width: 220px;
  background: #fff;
  border-right: 1px solid #e8e8e8;
  display: flex;
  flex-direction: column;
  flex-shrink: 0;
  overflow-y: auto;
}

.sidebar-header {
  padding: 1.2rem 1.2rem 1rem;
  border-bottom: 1px solid #f0f0f0;
  display: flex;
  align-items: center;
  gap: 0.6rem;
}

.logo-icon {
  font-size: 1.4rem;
}

.logo-text {
  font-size: 0.95rem;
  font-weight: 600;
  color: #333;
  letter-spacing: 1px;
}

.menu {
  list-style: none;
  padding: 0.5rem 0;
  margin: 0;
  flex: 1;
}

.menu li {
  margin: 1px 0;
}

.menu li a {
  display: flex;
  align-items: center;
  gap: 0.7rem;
  padding: 0.7rem 1.4rem;
  text-decoration: none;
  color: #555;
  transition: all 0.25s ease;
  border-left: 3px solid transparent;
  font-size: 0.93rem;
}

.menu li a:hover {
  background: #e8f5e9;
  color: #2e7d32;
}

.menu li.active a {
  background: #e8f5e9;
  color: #2e7d32;
  border-left-color: #4caf50;
  font-weight: 600;
}

.menu-icon {
  font-size: 1.15rem;
  width: 22px;
  text-align: center;
}

.sidebar-footer {
  padding: 1rem 1.4rem;
  border-top: 1px solid #f0f0f0;
  text-align: center;
}

.sidebar-footer p {
  font-size: 0.75rem;
  color: #bbb;
  margin: 0;
}

/* 右侧内容区 */
.content {
  flex: 1;
  padding: 1.5rem 2rem;
  min-height: 0;
  background: #f7f8fa;
  overflow-y: auto;
}

/* 面包屑 */
.breadcrumb {
  margin-bottom: 1.2rem;
  padding: 0.8rem 1rem;
  background: white;
  border-radius: 8px;
  border: 1px solid #eee;
}

/* 底部 */
.footer {
  background: #263238;
  color: #b0bec5;
  text-align: center;
  padding: 0.85rem;
  font-size: 0.82rem;
}

/* 动画 */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* 表格样式 */
.el-table th {
  background: #fafafa !important;
  font-weight: 600 !important;
  color: #333 !important;
}

.el-table tr:nth-child(even) {
  background: #fafafa !important;
}

/* 按钮样式 */
.el-button--primary {
  --el-button-bg-color: #4caf50 !important;
  --el-button-border-color: #4caf50 !important;
}

.el-button--primary:hover {
  --el-button-bg-color: #43a047 !important;
  --el-button-border-color: #43a047 !important;
}

/* 滚动条美化 */
::-webkit-scrollbar {
  width: 6px;
  height: 6px;
}

::-webkit-scrollbar-track {
  background: transparent;
}

::-webkit-scrollbar-thumb {
  background: #ccc;
  border-radius: 3px;
}

::-webkit-scrollbar-thumb:hover {
  background: #aaa;
}

@media screen and (max-width: 992px) {
  .sidebar {
    position: fixed;
    left: -220px;
    top: 56px;
    bottom: 0;
    z-index: 900;
    transition: left 0.3s ease;
    box-shadow: 2px 0 12px rgba(0,0,0,0.08);
  }

  .content {
    padding: 1rem;
  }
}
</style>
