<script setup lang="ts">
import { isAxiosError } from 'axios'
import { computed, onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'

import { clearSessionMarker } from '../../../shared/utils/sessionCookie'
import { logout, me } from '../api/authApi'
import type { UserResponse } from '../types/auth'

const router = useRouter()
const user = ref<UserResponse | null>(null)
const errorMessage = ref('')
const isLoading = ref(true)
const isLoggingOut = ref(false)

const roleLabel = computed(() =>
  user.value?.role === 'Admin' ? 'Administrador' : 'Usuario',
)

async function loadSession(): Promise<void> {
  isLoading.value = true
  errorMessage.value = ''

  try {
    user.value = await me()
  } catch (error) {
    if (!isAxiosError(error) || error.response?.status !== 401) {
      errorMessage.value =
        'No fue posible consultar la sesión. Verifica tu conexión e intenta nuevamente.'
    }
  } finally {
    isLoading.value = false
  }
}

async function endSession(): Promise<void> {
  isLoggingOut.value = true

  try {
    await logout()
  } catch {
    // The local session marker must disappear even if the API is unavailable.
  } finally {
    clearSessionMarker()
    await router.replace({ name: 'login' })
    isLoggingOut.value = false
  }
}

onMounted(loadSession)
</script>

<template>
  <div class="session-layout">
    <header class="site-header">
      <div class="site-header__inner">
        <div>
          <p>Tecnológico Nacional de México</p>
          <strong>Plataforma institucional</strong>
        </div>
        <button
          class="secondary-action"
          type="button"
          :disabled="isLoggingOut"
          @click="endSession"
        >
          {{ isLoggingOut ? 'Cerrando sesión…' : 'Cerrar sesión' }}
        </button>
      </div>
    </header>

    <main class="session-main">
      <div class="session-heading">
        <p>Sesión actual</p>
        <h1>{{ user ? `Bienvenido, ${user.name}` : 'Tu cuenta' }}</h1>
        <p>La API valida esta información en cada consulta protegida.</p>
      </div>

      <p v-if="isLoading" class="status-line" aria-live="polite">
        Consultando sesión…
      </p>

      <section v-else-if="user" class="identity-sheet" aria-labelledby="account-title">
        <h2 id="account-title">Datos de la cuenta</h2>
        <dl>
          <div>
            <dt>Nombre</dt>
            <dd>{{ user.name }}</dd>
          </div>
          <div>
            <dt>Usuario</dt>
            <dd>{{ user.username }}</dd>
          </div>
          <div>
            <dt>Correo</dt>
            <dd>{{ user.email }}</dd>
          </div>
          <div>
            <dt>Rol</dt>
            <dd>{{ roleLabel }}</dd>
          </div>
        </dl>
      </section>

      <section v-else class="load-error" aria-labelledby="load-error-title">
        <h2 id="load-error-title">No se pudo cargar la cuenta</h2>
        <p aria-live="assertive">{{ errorMessage }}</p>
        <button class="primary-action" type="button" @click="loadSession">
          Intentar nuevamente
        </button>
      </section>
    </main>
  </div>
</template>
