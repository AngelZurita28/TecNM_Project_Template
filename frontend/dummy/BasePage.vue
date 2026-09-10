<script setup lang="ts">
import { AlertTriangle, CheckCircle2 } from 'lucide-vue-next';

interface Props {
  title: string;
  subtitle?: string;
  fluid?: boolean; // Si es true, el ancho es 100%. Si es false, se limita a 1400px (centrado)
  loading?: boolean;
  loadingText?: string;
  errorMessage?: string;
  successMessage?: string;
}

withDefaults(defineProps<Props>(), {
  fluid: true,
  loading: false,
  loadingText: 'Cargando...',
  errorMessage: '',
  successMessage: ''
});
</script>

<template>
  <div 
    class="base-page-container fade-in" 
    :class="{ 'page-fluid': fluid }"
  >

    <!-- Sección de Filtros -->
    <slot name="filters"></slot>

    <!-- Alertas y Mensajes de Estado -->
    <div v-if="errorMessage" class="page-alert danger" role="alert">
      <AlertTriangle :size="18" />
      <span>{{ errorMessage }}</span>
    </div>

    <div v-if="successMessage" class="page-alert success" role="status">
      <CheckCircle2 :size="18" />
      <span>{{ successMessage }}</span>
    </div>

    <!-- Spinner de Carga -->
    <div v-if="loading" class="page-loading-overlay" role="status" aria-live="polite">
      <div class="spinner"></div>
      <p class="mt-2 text-secondary">{{ loadingText }}</p>
    </div>

    <!-- Contenido Principal -->
    <main v-else class="page-content">
      <slot></slot>
    </main>
  </div>
</template>

<style scoped>
.base-page-container {
  width: 100%;
  max-width: var(--page-max-width, 1400px);
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: var(--space-lg);
}

.base-page-container.page-fluid {
  max-width: 100%;
}

.base-page-header {
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  gap: var(--space-md);
  padding-bottom: var(--space-md);
  border-bottom: 1px solid var(--glass-border);
}

@media (min-width: 768px) {
  .base-page-header {
    flex-direction: row;
    align-items: flex-end;
  }
}

.page-title {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
  margin-bottom: 4px;
}

.page-subtitle {
  font-size: 0.88rem;
  color: var(--text-secondary);
  margin: 0;
}

.header-actions {
  display: flex;
  flex-wrap: wrap;
  gap: var(--space-sm);
}

.page-alert {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
  border-radius: var(--radius-control);
  padding: var(--space-md);
  font-weight: 500;
  font-size: 0.9rem;
  border: 1px solid transparent;
}

.page-alert.danger {
  background: rgba(248, 113, 113, 0.12);
  color: var(--danger-color);
  border-color: rgba(248, 113, 113, 0.25);
}

.page-alert.success {
  background: var(--table-success-bg);
  color: var(--success-color);
  border-color: var(--stat-border);
}

.page-loading-overlay {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 300px;
}

.spinner {
  border: 4px solid var(--glass-border);
  width: 40px;
  height: 40px;
  border-radius: 50%;
  border-left-color: var(--accent);
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.page-content {
  width: 100%;
}
</style>
