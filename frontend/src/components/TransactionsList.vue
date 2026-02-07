<template>
  <div class="card border-0 shadow-sm">
    <div class="table-responsive">
      <table class="table table-hover align-middle mb-0 w-100">
        <thead class="bg-light text-muted small text-uppercase">
          <tr>
            <th class="ps-4 py-3">Data</th>
            <th>Descrição</th>
            <th>Categoria</th>
            <th class="text-end pe-4">Valor</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="t in transactions" :key="t.id">
            <td class="ps-4">{{ formatDate(t.date) }}</td>
            <td class="fw-semibold">{{ t.description }}</td>
            <td>
              <span class="badge rounded-pill" :style="{ backgroundColor: t.category?.color || '#6c757d' }">
                {{ t.category?.name || 'Geral' }}
              </span>
            </td>
            <td class="text-end pe-4 fw-bold" :class="t.transaction_type === 'expense' ? 'text-danger' : 'text-success'">
              {{ t.transaction_type === 'expense' ? '-' : '+' }} {{ formatCurrency(t.amount) }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const transactions = ref([])

const formatDate = (d) => d ? new Date(d).toLocaleDateString('pt-BR') : '--/--/----'

const formatCurrency = (v) => {
  const n = parseFloat(v)
  return isNaN(n) ? "R$ 0,00" : n.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })
}

const fetchTransactions = async () => {
  const res = await fetch('http://localhost:3000/transactions')
  transactions.value = await res.json()
}

onMounted(fetchTransactions)
</script>
