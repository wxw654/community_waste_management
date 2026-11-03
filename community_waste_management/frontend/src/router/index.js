import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/Home.vue')
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Auth.vue')
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('../views/Auth.vue')
  },
  {
    path: '/guides',
    name: 'Guides',
    component: () => import('../views/Guides.vue'),
    children: [
      {
        path: '',
        name: 'GuideHome',
        component: () => import('../views/GuideDetail.vue')
      },
      {
        path: ':category',
        name: 'GuideCategory',
        component: () => import('../views/GuideDetail.vue')
      }
    ]
  },
  {
    path: '/points',
    name: 'Points',
    component: () => import('../views/Points.vue'),
    children: [
      {
        path: '',
        name: 'PointsList',
        component: () => import('../views/PointDetail.vue')
      },
      {
        path: ':id',
        name: 'PointInfo',
        component: () => import('../views/PointDetail.vue')
      }
    ]
  },
  {
    path: '/records',
    name: 'Records',
    component: () => import('../views/Records.vue')
  },
  {
    path: '/products',
    name: 'Products',
    component: () => import('../views/Products.vue'),
    children: [
      {
        path: '',
        name: 'ProductsList',
        component: () => import('../views/ProductDetail.vue')
      },
      {
        path: 'product/:id',
        name: 'ProductInfo',
        component: () => import('../views/ProductDetail.vue')
      },
      {
        path: 'orders',
        name: 'Orders',
        component: () => import('../views/Orders.vue')
      }
    ]
  },
  {
    path: '/activities',
    name: 'Activities',
    component: () => import('../views/Activities.vue'),
    children: [
      {
        path: '',
        name: 'ActivityList',
        component: () => import('../views/ActivityDetail.vue')
      },
      {
        path: ':id',
        name: 'ActivityInfo',
        component: () => import('../views/ActivityDetail.vue')
      }
    ]
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: () => import('../views/Dashboard.vue')
  },
  {
    path: '/profile',
    name: 'Profile',
    component: () => import('../views/Profile.vue')
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
