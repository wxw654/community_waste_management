# 社区垃圾分类管理系统 (Community Waste Management System)

基于 Django + Vue3 的前后端分离社区垃圾分类管理系统，支持居民投放、积分激励、智能监控、活动运营等完整业务流程。

## 技术栈

### 后端
| 技术 | 版本 | 说明 |
|------|------|------|
| Python | 3.13 | 运行环境 |
| Django | 4.2 | Web 框架 |
| Django REST Framework | - | RESTful API |
| SimpleJWT | - | JWT 身份认证 |
| MySQL | 8.0 | 数据库 |
| django-simpleui | - | Admin 后台美化 |

### 前端
| 技术 | 版本 | 说明 |
|------|------|------|
| Vue | 3.3 | 前端框架 |
| Vite | 4.5 | 构建工具 |
| Vue Router | 4.2 | 路由管理 |
| Element Plus | 2.3 | UI 组件库 |
| ECharts | 5.4 | 数据可视化 |
| Axios | 1.5 | HTTP 客户端 |

## 项目结构

```
community_waste_management/
├── manage.py                          # Django 管理入口
├── community_waste_management/         # 项目配置
│   ├── settings.py                    # 全局配置（数据库/中间件/JWT/CORS等）
│   ├── urls.py                        # 根路由配置
│   └── wsgi.py / asgi.py              # 部署入口
│
├── api/                               # API 接口层
│   ├── views_optimized.py             # 所有 ViewSet（核心业务逻辑）
│   ├── serializers.py                 # 序列化器定义
│   └── urls.py                        # API 路由分发
│
├── apps/                              # 业务应用目录
│   ├── users/                         # 用户管理（User + House）
│   │   ├── models.py                  # 用户模型、房屋模型
│   │   ├── admin.py                   # Admin 注册
│   │   └── management/commands/
│   │       └── seed_data.py           # 种子数据填充脚本
│   │
│   ├── points/                        # 投放点管理（WastePoint + Sensor）
│   │   ├── models.py                  # 投放点模型、传感器模型
│   │   └── migrations/                # 数据库迁移
│   │
│   ├── waste_records/                 # 垃圾分类记录（WasteCategory + WasteRecord + PointTransaction）
│   │   ├── models.py                  # 垃圾类别、投放记录、积分交易
│   │   └── migrations/
│   │
│   ├── products/                      # 积分商城（Product + Order）
│   │   ├── models.py                  # 商品模型、订单模型
│   │   └── migrations/
│   │
│   ├── guides/                        # 分类指南（GuideCategory + GuideItem + FAQ）
│   │   ├── models.py                  # 指南分类、指南内容、常见问题
│   │   └── migrations/
│   │
│   ├── activities/                    # 活动管理（Activity + ActivityParticipant + Notification）
│   │   ├── models.py                  # 活动、参与记录、通知消息
│   │   └── migrations/
│   │
│   └── feedback/                      # 反馈互动（Feedback + PointEvaluation + ViolationReport）
│       ├── models.py                  # 用户反馈、投放点评价、违规举报
│       └── migrations/
│
├── frontend/                          # Vue3 前端项目
│   ├── index.html                     # 入口 HTML
│   ├── package.json                   # 依赖配置
│   ├── vite.config.js                 # Vite 配置（API代理到后端8000端口）
│   └── src/
│       ├── main.js                    # 应用入口
│       ├── App.vue                    # 根组件
│       ├── router/index.js            # 路由配置
│       ├── utils/api.js               # API 请求封装
│       └── views/                     # 页面组件
│           ├── Home.vue               # 首页
│           ├── Auth.vue               # 登录注册
│           ├── Dashboard.vue          # 数据仪表盘
│           ├── Records.vue            # 投放记录
│           ├── Points.vue             # 积分中心
│           ├── Products.vue           # 积分商城
│           ├── Orders.vue             # 订单列表
│           ├── Guides.vue             # 分类指南
│           ├── Activities.vue         # 活动中心
│           └── Profile.vue            # 个人中心
│
└── README.md                         # 项目说明文档
```

## 功能模块

### 1. 用户管理
- 四种角色：居民(resident)、管理员(admin)、巡检员(inspector)、物业(property)
- JWT 令牌认证（访问令牌 2h / 刷新令牌 7d）
- 房屋绑定、个人信息管理、密码修改

### 2. 垃圾分类投放
- 即时投放与预约投放两种模式
- 扫码识别 / 手动选择投放点
- AI 分类识别辅助
- 积分自动计算：`合格: 重量 × 10 × point_value`，不合格减半
- 用户等级：新手(<100) / 达人(<500) / 模范(≥500)

### 3. 投放点管理
- CRUD 管理（名称、位置、经纬度、容量、开放时间等）
- 实时状态监控：正常(normal) / 警告(warning, ≥70%) / 满溢(full, ≥90%) / 离线 / 维护中
- 满溢自动触发通知
- 清运计划管理
- 传感器数据上报与同步

### 4. 积分商城
- 商品上下架、库存管理
- 居民兑换（库存校验 + 积分校验）
- 订单领取确认
- 库存补货操作

### 5. 活动管理
- 活动创建与发布
- 居民参与（防重复）+ 自动发放奖励积分
- 参与率统计、楼栋分布分析

### 6. 反馈互动
- 用户反馈（待处理 → 已处理/已关闭）
- 违规举报（待审核 → 已确认/已驳回）
- 投放点评价（清洁度 + 设备状况，1-5 分）

### 7. 分类指南 & FAQ
- 多级分类指南（图文视频支持）
- FAQ 问答检索
- 个性化分类推荐

### 8. 数据分析与报告
- 今日统计仪表盘
- 垃圾分类趋势图
- 用户行为分析
- 积分排行榜

## 快速开始

### 环境要求
- Python 3.11+
- Node.js 16+
- MySQL 8.0+

### 1. 克隆项目
```bash
cd community_waste_management
```

### 2. 后端配置
```bash
# 创建虚拟环境并激活
python -m venv .venv
.venv\Scripts\activate

# 安装依赖
pip install -r requirements.txt

# 安装 MySQL 驱动
pip install mysqlclient
```

### 3. 数据库配置
编辑 `community_waste_management/settings.py`，修改数据库连接信息：
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'community_waste_db',
        'USER': 'root',
        'PASSWORD': '你的密码',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}
```

### 4. 执行数据库迁移
```bash
python manage.py makemigrations
python manage.py migrate
```

### 5. 创建管理员账号
```bash
python manage.py createsuperuser
```

### 6. 填充测试数据（可选）
```bash
python manage.py seed_data
python manage.py seed_data --clean   # 清空后重新填充
```

### 7. 启动后端服务
```bash
python manage.py runserver 0.0.0.0:8000
```
后端地址：http://127.0.0.1:8000/

### 8. 启动前端服务
```bash
cd frontend
npm install
npm run dev
```
前端地址：http://localhost:5173/

## API 接口

基础路径：`/api/`

| 模块 | 路径 | 说明 |
|------|------|------|
| 认证 | `/api/auth/login/` | 登录获取 JWT 令牌 |
| 认证 | `/api/auth/register/` | 用户注册 |
| 用户 | `/api/users/` | 用户管理 |
| 房屋 | `/api/houses/` | 房屋绑定 |
| 投放点 | `/api/waste-points/` | 投放点 CRUD |
| 投放点 | `/api/waste-points/nearby/` | 附近投放点查询 |
| 投放点 | `/api/waste-points/{id}/update_status/` | 更新投放点状态 |
| 投放点 | `/api/waste-points/{id}/schedule_cleanup/` | 设置清运计划 |
| 投放点 | `/api/waste-points/monitor/` | 实时监控概览 |
| 传感器 | `/api/sensors/` | 传感器管理 |
| 传感器 | `/api/sensors/{id}/report_data/` | 传感器数据上报 |
| 垃圾类别 | `/api/waste-categories/` | 类别管理 |
| 垃圾类别 | `/api/waste-categories/search/` | 搜索类别 |
| 投放记录 | `/api/waste-records/` | 投放记录 CRUD |
| 积分交易 | `/api/point-transactions/` | 积分变动记录 |
| 商品 | `/api/products/` | 商品管理 |
| 商品 | `/api/products/available/` | 可兑换商品 |
| 商品 | `/api/products/{id}/exchange/` | 兑换商品 |
| 商品 | `/api/products/{id}/restock/` | 补充库存 |
| 订单 | `/api/orders/` | 订单管理 |
| 订单 | `/api/orders/{id}/pickup/` | 确认领取 |
| 指南分类 | `/api/guide-categories/` | 指南分类 |
| 指南内容 | `/api/guide-items/` | 指南条目 |
| FAQ | `/api/faqs/` | 常见问题 |
| 活动 | `/api/activities/` | 活动管理 |
| 参与 | `/api/activity-participants/` | 参与记录 |
| 通知 | `/api/notifications/` | 通知消息 |
| 反馈 | `/api/feedbacks/` | 用户反馈 |
| 评价 | `/api/point-evaluations/` | 投放点评价 |
| 举报 | `/api/violation-reports/` | 违规举报 |
| 报告 | `/api/reports/dashboard/` | 数据仪表盘 |
| 报告 | `/api/reports/waste-statistics/` | 垃圾分类统计 |
| 报告 | `/api/reports/user-analysis/` | 用户行为分析 |
| 推荐 | `/api/recommendations/tips/` | 个性化推荐 |
| 推荐 | `/api/recommendations/nearby-points/` | 推荐空闲投放点 |
| 备份 | `/api/backups/backup/` | 数据备份 |
| 备份 | `/api/backups/restore/` | 数据恢复 |

## 测试账号

| 角色 | 用户名 | 密码 | 功能权限 |
|------|--------|------|----------|
| 管理员 | admin | admin123 | 全部管理功能 |
| 居民 | resident1 | password123 | 投放、兑换、反馈、评价 |
| 巡检员 | inspector1 | password123 | 监控、审核举报 |
| 物业 | property1 | password123 | 清运管理 |

> 使用 `python manage.py seed_data` 可批量生成测试用户和数据。

## 安全特性

- **身份认证**：JWT 双令牌机制（Access Token + Refresh Token），支持令牌轮换与黑名单
- **密码安全**：Django PBKDF2 加密存储，支持密码强度校验
- **SQL 注入防护**：ORM 参数化查询，杜绝 SQL 注入
- **XSS 攻击防护**：前端转义 + 后端过滤，防止脚本注入
- **CORS 跨域**：前后端分离架构下的跨域请求控制
- **敏感信息脱敏**：API 返回数据自动脱敏处理

