<template>
  <div class="guides">
    <el-tabs v-model="activeTab" @tab-click="handleTabClick" class="guide-tabs">
      <el-tab-pane label="分类指南" name="guide">
        <div class="page-header">
          <h2>垃圾分类指南</h2>
        </div>

        <div class="category-cards">
          <el-card
            v-for="category in categories"
            :key="category.code"
            :class="['category-card', category.code]"
            shadow="hover"
            @click="viewCategoryDetail(category)"
          >
            <div class="card-content">
              <div class="category-icon">{{ category.icon }}</div>
              <h3>{{ category.type }}</h3>
              <p>{{ category.details }}</p>
              <el-button type="primary" size="small" @click.stop="viewCategoryDetail(category)">
                查看详情
              </el-button>
            </div>
          </el-card>
        </div>

        <el-card class="quick-tags-card">
          <template #header>
            <span>常见物品快速查询</span>
          </template>
          <div class="quick-tags">
            <el-tag
              v-for="item in quickItems"
              :key="item.name"
              :type="getTagType(item.category)"
              effect="plain"
              class="tag-item"
              @click="searchItem(item.name)"
            >
              {{ item.name }}
            </el-tag>
          </div>
        </el-card>
      </el-tab-pane>

      <el-tab-pane label="分类指南详情" name="detail">
        <div class="page-header">
          <h2 v-if="selectedCategory">{{ selectedCategory.type }} - 详细说明</h2>
          <h2 v-else>请先选择一个垃圾类别</h2>
        </div>

        <div v-if="selectedCategory" class="detail-content">
          <el-card class="detail-card">
            <div class="detail-header">
              <span class="detail-icon">{{ selectedCategory.icon }}</span>
              <div class="detail-title">
                <h3>{{ selectedCategory.type }}</h3>
                <el-tag :type="getStatusType(selectedCategory.code)" size="large">
                  {{ selectedCategory.code }}
                </el-tag>
              </div>
            </div>

            <el-divider></el-divider>

            <div class="detail-section">
              <h4>基本定义</h4>
              <p>{{ selectedCategory.description }}</p>
            </div>

            <div class="detail-section">
              <h4>包含物品</h4>
              <div class="items-grid">
                <div
                  v-for="(item, index) in selectedCategory.items"
                  :key="index"
                  class="item-badge"
                >
                  {{ item }}
                </div>
              </div>
            </div>

            <div class="detail-section">
              <h4>投放要求</h4>
              <ul class="requirements-list">
                <li v-for="(req, index) in selectedCategory.requirements" :key="index">
                  {{ req }}
                </li>
              </ul>
            </div>

            <div class="detail-section">
              <h4>注意事项</h4>
              <ul class="notes-list">
                <li v-for="(note, index) in selectedCategory.notes" :key="index">
                  {{ note }}
                </li>
              </ul>
            </div>
          </el-card>
        </div>

        <el-empty v-else description="请从分类指南中选择一个类别查看详情"></el-empty>
      </el-tab-pane>

      <el-tab-pane label="垃圾分类搜索" name="search">
        <div class="page-header">
          <h2>垃圾分类搜索</h2>
        </div>

        <el-card class="search-card">
          <el-input
            v-model="searchQuery"
            placeholder="输入垃圾名称搜索，例如：塑料瓶、电池、剩饭..."
            size="large"
            clearable
            @keyup.enter="searchWaste"
          >
            <template #prefix>
              <el-icon><Search /></el-icon>
            </template>
            <template #append>
              <el-button type="primary" @click="searchWaste">搜索</el-button>
            </template>
          </el-input>
        </el-card>

        <div class="hot-search">
          <h3>热门搜索</h3>
          <div class="hot-tags">
            <el-tag
              v-for="item in hotSearchItems"
              :key="item"
              class="hot-tag"
              effect="plain"
              @click="searchItem(item)"
            >
              {{ item }}
            </el-tag>
          </div>
        </div>

        <div v-if="searchResults.length > 0" class="search-results">
          <h3>搜索结果</h3>
          <el-table :data="searchResults" style="width: 100%">
            <el-table-column prop="name" label="物品名称"></el-table-column>
            <el-table-column prop="category" label="所属分类" width="150">
              <template #default="scope">
                <el-tag :type="getTagType(scope.row.categoryCode)">
                  {{ scope.row.category }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="tips" label="投放提示"></el-table-column>
          </el-table>
        </div>

        <el-empty v-else-if="hasSearched && searchResults.length === 0" description="未找到相关结果，请尝试其他关键词"></el-empty>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { Search } from '@element-plus/icons-vue'

export default {
  name: 'Guides',
  components: {
    Search
  },
  data() {
    return {
      activeTab: 'guide',
      searchQuery: '',
      hasSearched: false,
      selectedCategory: null,
      categories: [
        {
          code: 'A',
          type: '可回收物',
          icon: '♻️',
          details: '纸类、塑料、玻璃、金属、织物',
          description: '可回收物是指适宜回收利用和资源化利用的生活废弃物，包括废纸、废塑料、废金属、废包装物、废旧纺织物、废弃电器电子产品、废玻璃、废纸塑铝复合包装等。',
          items: ['报纸', '书本', '纸箱', '塑料瓶', '塑料玩具', '玻璃瓶', '易拉罐', '铁锅', '旧衣服', '旧床单'],
          requirements: ['轻投轻放', '清洁干燥，避免污染', '废纸尽量平整', '立体包装请清空内容物，淋洗干净', '有尖锐边角的应包裹后投放'],
          notes: ['不可回收的纸类：卫生纸、餐巾纸等', '不可回收的塑料：塑料袋、保鲜膜等受污染的塑料制品']
        },
        {
          code: 'B',
          type: '厨余垃圾',
          icon: '🥬',
          details: '剩菜剩饭、果皮、蔬菜叶',
          description: '厨余垃圾是指居民日常生活及食品加工、饮食服务、单位供餐等活动中产生的垃圾，包括丢弃不用的菜叶、剩菜、剩饭、果皮、蛋壳、茶渣、骨头（大骨除外）等。',
          items: ['剩饭菜', '果皮', '蔬菜叶', '蛋壳', '茶叶渣', '过期食品', '鱼骨', '鸡骨', '中药药渣'],
          requirements: ['纯流质的食物垃圾，应直接倒进下水口', '有包装物的湿垃圾应将包装物去除后分类投放', '投放前沥干水分'],
          notes: ['大骨头属于其他垃圾', '贝壳类属于其他垃圾']
        },
        {
          code: 'C',
          type: '有害垃圾',
          icon: '☠️',
          details: '电池、灯管、药品、油漆桶',
          description: '有害垃圾是指对人体健康或者自然环境造成直接或者潜在危害的生活废弃物。主要包括废电池、废灯管、废药品、废油漆及其容器等。',
          items: ['废电池', '废灯管', '废药品', '废油漆桶', '杀虫剂', '消毒剂', '水银温度计', '血压计', '胶片相纸'],
          requirements: ['分类投放有害垃圾时，应注意轻放', '易破损的废弃药品应连带包装或包裹后投放', '如易挥发，请密封后投放'],
          notes: ['废弃的荧光灯管灯泡投放时要小心打包固定，以免灯管破碎', '除废弃指甲油、染发剂等外，其他日用化学品需连同包装一起投放']
        },
        {
          code: 'D',
          type: '其他垃圾',
          icon: '🗑️',
          details: '烟头、卫生纸、塑料袋',
          description: '其他垃圾是指除可回收物、厨余垃圾和有害垃圾之外的其他生活废弃物。包括受污染与无法再生的纸张、受污染或其他不可回收的玻璃、塑料袋与其他受污染的塑料制品、废旧衣物与其他纺织品、破旧陶瓷品、妇女卫生用品、一次性餐具、烟头、灰土等。',
          items: ['卫生纸', '餐巾纸', '烟蒂', '猫砂', '狗屎袋', '破碎陶瓷', '尘土', '一次性餐具', '大骨头', '贝壳'],
          requirements: ['尽量沥干水分', '难以辨识类别的生活垃圾投入其他垃圾容器中'],
          notes: ['注意：普通一次性电池（碱性电池）不属于有害垃圾，应投入其他垃圾']
        }
      ],
      quickItems: [
        { name: '塑料瓶', category: 'A' },
        { name: '报纸', category: 'A' },
        { name: '易拉罐', category: 'A' },
        { name: '剩饭', category: 'B' },
        { name: '果皮', category: 'B' },
        { name: '电池', category: 'C' },
        { name: '灯管', category: 'C' },
        { name: '卫生纸', category: 'D' },
        { name: '烟蒂', category: 'D' }
      ],
      hotSearchItems: ['塑料瓶', '外卖盒', '电池', '口罩', '快递包装', '奶茶杯', '鸡蛋壳', '旧衣服', '玻璃瓶', '过期药品'],
      searchResults: []
    }
  },
  methods: {
    handleTabClick(tab) {
      this.activeTab = tab.props.name
    },
    viewCategoryDetail(category) {
      this.selectedCategory = category
      this.activeTab = 'detail'
    },
    searchWaste() {
      if (!this.searchQuery.trim()) {
        this.$message.warning('请输入搜索关键词')
        return
      }

      this.hasSearched = true
      const query = this.searchQuery.toLowerCase().trim()
      this.searchResults = []

      this.categories.forEach(category => {
        category.items.forEach(item => {
          if (item.includes(query)) {
            this.searchResults.push({
              name: item,
              category: category.type,
              categoryCode: category.code,
              tips: `请投放至${category.type}垃圾桶`
            })
          }
        })
      })

      if (this.searchResults.length === 0) {
        this.$message.info('未找到匹配的结果')
      } else {
        this.$message.success(`找到 ${this.searchResults.length} 条相关结果`)
      }
    },
    searchItem(itemName) {
      this.searchQuery = itemName
      this.activeTab = 'search'
      this.$nextTick(() => {
        this.searchWaste()
      })
    },
    getTagType(code) {
      switch(code) {
        case 'A': return ''
        case 'B': return 'success'
        case 'C': return 'danger'
        case 'D': return 'info'
        default: return ''
      }
    },
    getStatusType(code) {
      switch(code) {
        case 'A': return ''
        case 'B': return 'success'
        case 'C': return 'danger'
        case 'D': return 'warning'
        default: return ''
      }
    }
  }
}
</script>

<style scoped>
.guides {
  padding: 1rem;
}

.guide-tabs {
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

.category-cards {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.category-card {
  cursor: pointer;
  transition: all 0.3s ease;
  border-top: 4px solid #409eff;
}

.category-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 25px rgba(0,0,0,0.15);
}

.category-card.A {
  border-top-color: #409eff;
}

.category-card.B {
  border-top-color: #67c23a;
}

.category-card.C {
  border-top-color: #f56c6c;
}

.category-card.D {
  border-top-color: #909399;
}

.card-content {
  text-align: center;
  padding: 1rem;
}

.category-icon {
  font-size: 4rem;
  margin-bottom: 1rem;
}

.card-content h3 {
  font-size: 1.3rem;
  margin-bottom: 0.5rem;
  color: #333;
}

.card-content p {
  color: #666;
  font-size: 0.9rem;
  margin-bottom: 1rem;
  line-height: 1.5;
}

.quick-tags-card {
  margin-top: 1.5rem;
}

.quick-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.8rem;
}

.tag-item {
  cursor: pointer;
  transition: all 0.3s ease;
  padding: 0.5rem 1rem;
  font-size: 0.95rem;
}

.tag-item:hover {
  transform: scale(1.05);
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
}

.detail-content {
  animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.detail-card {
  max-width: 900px;
  margin: 0 auto;
}

.detail-header {
  display: flex;
  align-items: center;
  gap: 1.5rem;
  margin-bottom: 1rem;
}

.detail-icon {
  font-size: 4rem;
}

.detail-title h3 {
  margin: 0;
  font-size: 1.5rem;
  color: #333;
}

.detail-section {
  margin: 1.5rem 0;
}

.detail-section h4 {
  color: #333;
  margin-bottom: 0.8rem;
  font-size: 1.1rem;
}

.detail-section p {
  color: #666;
  line-height: 1.8;
  text-indent: 2em;
}

.items-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 0.8rem;
}

.item-badge {
  background: #f0f9eb;
  color: #67c23a;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.9rem;
  border: 1px solid #c2e7b0;
}

.requirements-list, .notes-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.requirements-list li, .notes-list li {
  padding: 0.5rem 0;
  padding-left: 1.5rem;
  position: relative;
  color: #666;
  line-height: 1.6;
}

.requirements-list li::before {
  content: '✓';
  position: absolute;
  left: 0;
  color: #67c23a;
  font-weight: bold;
}

.notes-list li::before {
  content: '!';
  position: absolute;
  left: 0;
  color: #e6a23c;
  font-weight: bold;
}

.search-card {
  margin-bottom: 2rem;
  max-width: 700px;
  margin-left: auto;
  margin-right: auto;
}

.hot-search {
  margin-bottom: 2rem;
}

.hot-search h3 {
  color: #333;
  margin-bottom: 1rem;
  font-size: 1.1rem;
}

.hot-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.8rem;
}

.hot-tag {
  cursor: pointer;
  transition: all 0.3s ease;
  padding: 0.5rem 1rem;
}

.hot-tag:hover {
  background-color: #ecf5ff;
  color: #409eff;
  border-color: #409eff;
}

.search-results {
  margin-top: 2rem;
}

.search-results h3 {
  color: #333;
  margin-bottom: 1rem;
}
</style>
