<template>
  <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-4">
    <div v-for="cat in categories" :key="cat.id" class="col">
      <div class="card h-100 shadow-sm border-0 rounded-4 overflow-hidden">
        <div class="py-3 text-center text-white fw-bold text-uppercase" 
             :style="{ backgroundColor: cat.color || '#0d6efd' }">
          {{ cat.name }}
        </div>
        
        <div class="card-body text-center py-4">
          <p class="text-muted mb-1 small">GASTO ATUAL</p>
          <h2 class="fw-bold mb-0 text-dark">{{ formatCurrency(cat.total_spent) }}</h2>
          
          <div class="progress mt-3 mx-auto" style="height: 10px; width: 85%;">
            <div class="progress-bar rounded-pill" 
                 :class="parseFloat(cat.total_spent) > parseFloat(cat.monthly_limit) ? 'bg-danger' : 'bg-success'" 
                 :style="{ width: calculateProgress(cat) + '%' }">
            </div>
          </div>
          <div class="mt-3">
            <small class="text-muted">Limite: <strong>{{ formatCurrency(cat.monthly_limit) }}</strong></small>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const categories = ref([])

const formatCurrency = (val) => {
  const n = parseFloat(val)
  return isNaN(n) ? "R$ 0,00" : n.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })
}

const calculateProgress = (cat) => {
  const progress = (cat.total_spent / cat.monthly_limit) * 100
  return Math.min(progress, 100)
}

const fetchCategories = async () => {
  const res = await fetch('http://localhost:3000/categories')
  categories.value = await res.json()
}

onMounted(fetchCategories)
</script>
