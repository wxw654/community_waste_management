<template>
  <div class="home">
    <div class="hero">
      <h2>欢迎使用社区垃圾分类管理系统</h2>
      <p>让我们一起为环保贡献力量，共建美好社区</p>
      <div class="actions">
        <router-link to="/register" class="btn primary">立即注册</router-link>
        <router-link to="/login" class="btn secondary">登录</router-link>
      </div>
    </div>
    <div class="features">
      <div class="feature">
        <h3>智能投放点</h3>
        <p>实时监控投放点状态，合理安排投放时间</p>
        <router-link to="/points" class="btn link">查看投放点</router-link>
      </div>
      <div class="feature">
        <h3>积分激励</h3>
        <p>投放垃圾获得积分，兑换精美礼品</p>
        <router-link to="/products" class="btn link">积分商城</router-link>
      </div>
      <div class="feature">
        <h3>分类指南</h3>
        <p>详细的垃圾分类标准和投放指南</p>
        <router-link to="/guides" class="btn link">查看指南</router-link>
      </div>
      <div class="feature">
        <h3>社区活动</h3>
        <p>参与分类活动，赢取额外积分奖励</p>
        <router-link to="/activities" class="btn link">活动中心</router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Home'
}
</script>

<style scoped>
.home {
  max-width: 1200px;
  margin: 0 auto;
}

.hero {
  text-align: center;
  padding: 4rem 2rem;
  background: linear-gradient(135deg, #4CAF50 0%, #2E7D32 100%);
  color: white;
  border-radius: 8px;
  margin-bottom: 2rem;
}

.hero h2 {
  font-size: 2.5rem;
  margin-bottom: 1rem;
}

.hero p {
  font-size: 1.2rem;
  margin-bottom: 2rem;
}

.actions {
  display: flex;
  gap: 1rem;
  justify-content: center;
}

.btn {
  padding: 0.8rem 1.5rem;
  border-radius: 4px;
  text-decoration: none;
  font-weight: bold;
  transition: background-color 0.3s;
}

.btn.primary {
  background: white;
  color: #4CAF50;
}

.btn.primary:hover {
  background: #f0f0f0;
}

.btn.secondary {
  background: transparent;
  color: white;
  border: 2px solid white;
}

.btn.secondary:hover {
  background: rgba(255,255,255,0.2);
}

.features {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.feature {
  background: #f9f9f9;
  padding: 2rem;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  text-align: center;
}

.feature h3 {
  margin-bottom: 1rem;
  color: #4CAF50;
}

.feature p {
  margin-bottom: 1.5rem;
  color: #666;
}

.btn.link {
  background: #4CAF50;
  color: white;
}

.btn.link:hover {
  background: #45a049;
}

@media (max-width: 768px) {
  .actions {
    flex-direction: column;
    align-items: center;
  }
  
  .btn {
    width: 200px;
    text-align: center;
  }
}
</style>
