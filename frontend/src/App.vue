<template>
  <div class="min-vh-100 bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm px-4 py-2">
      <div class="container-fluid">
        <a class="navbar-brand fw-bold fs-3" href="#" @click.prevent="currentView = 'dashboard'">DINDIN 💰</a>
        
        <div class="navbar-nav me-auto flex-row gap-3">
          <button 
            @click="currentView = 'dashboard'" 
            class="nav-link btn border-0 fw-semibold" 
            :class="{ active: currentView === 'dashboard' }">
            Dashboard
          </button>
          <button 
            @click="currentView = 'transactions'" 
            class="nav-link btn border-0 fw-semibold" 
            :class="{ active: currentView === 'transactions' }">
            Lançamentos
          </button>
        </div>

        <button class="btn btn-light fw-bold shadow-sm px-4" data-bs-toggle="modal" data-bs-target="#transactionModal">
          + Novo Lançamento
        </button>
      </div>
    </nav>

    <main class="container-fluid p-4">
      <Dashboard v-if="currentView === 'dashboard'" />
      <TransactionsList v-else />
    </main>

    <div class="modal fade" id="transactionModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
          <form @submit.prevent="saveTransaction">
            <div class="modal-header border-0 pb-0">
              <h5 class="modal-title fw-bold">Novo Lançamento</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body py-4">
              <div class="mb-3">
                <label class="form-label small fw-bold text-muted">DESCRIÇÃO</label>
                <input v-model="form.description" type="text" class="form-control form-control-lg rounded-3" placeholder="Ex: Mercado" required>
              </div>
              <div class="row">
                <div class="col-6 mb-3">
                  <label class="form-label small fw-bold text-muted">VALOR (R$)</label>
                  <input v-model="form.amount" type="number" step="0.01" class="form-control form-control-lg rounded-3" required>
                </div>
                <div class="col-6 mb-3">
                  <label class="form-label small fw-bold text-muted">DATA</label>
                  <input v-model="form.date" type="date" class="form-control form-control-lg rounded-3" required>
                </div>
              </div>
              <div class="mb-3">
                <label class="form-label small fw-bold text-muted">CATEGORIA</label>
                <select v-model="form.category_id" class="form-select form-select-lg rounded-3" required>
                  <option v-for="cat in categories" :key="cat.id" :value="cat.id">{{ cat.name }}</option>
                </select>
              </div>
            </div>
            <div class="modal-footer border-0 pt-0">
              <button type="button" class="btn btn-light fw-bold" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn btn-primary fw-bold px-4">Salvar Lançamento</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import * as bootstrap from 'bootstrap'
import Dashboard from './components/Dashboard.vue'
import TransactionsList from './components/TransactionsList.vue'

const currentView = ref('dashboard')
const categories = ref([])

const initialFormState = {
  description: '',
  amount: 0,
  date: new Date().toISOString().substr(0, 10),
  category_id: '',
  transaction_type: 'expense',
  status: 'confirmed'
}
const form = ref({ ...initialFormState })

const fetchCategories = async () => {
  const res = await fetch('http://localhost:3000/categories')
  categories.value = await res.json()
}

const saveTransaction = async () => {
  try {
    const response = await fetch('http://localhost:3000/transactions', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ transaction: form.value })
    })

    if (response.ok) {
      const modalElement = document.getElementById('transactionModal')
      const modalInstance = bootstrap.Modal.getOrCreateInstance(modalElement)
      modalInstance.hide()
      
      // Limpeza manual para evitar o fundo travado
      document.querySelectorAll('.modal-backdrop').forEach(el => el.remove())
      document.body.classList.remove('modal-open')
      document.body.style.overflow = ''

      form.value = { ...initialFormState }
      window.location.reload() // Força a atualização dos componentes filhos
    }
  } catch (error) {
    console.error("Erro ao salvar:", error)
  }
}

onMounted(fetchCategories)
</script>

<style>
body { margin: 0; }
.nav-link.active { border-bottom: 3px solid white; color: white !important; }
</style>
