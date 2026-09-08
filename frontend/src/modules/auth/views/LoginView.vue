<script setup lang="ts">
import { isAxiosError } from 'axios'
import { nextTick, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'

import { login } from '../api/authApi'

const route = useRoute()
const router = useRouter()

const username = ref('')
const password = ref('')
const usernameError = ref('')
const passwordError = ref('')
const formMessage = ref('')
const isSubmitting = ref(false)
const usernameInput = ref<HTMLInputElement | null>(null)
const passwordInput = ref<HTMLInputElement | null>(null)

function clearUsernameError(): void {
  usernameError.value = ''
  formMessage.value = ''
}

function clearPasswordError(): void {
  passwordError.value = ''
  formMessage.value = ''
}

async function submit(): Promise<void> {
  usernameError.value = username.value.trim() ? '' : 'Ingresa tu usuario.'
  passwordError.value = password.value ? '' : 'Ingresa tu contraseña.'
  formMessage.value = ''

  if (usernameError.value || passwordError.value) {
    formMessage.value = 'Completa los campos señalados.'
    await nextTick()
    ;(usernameError.value ? usernameInput.value : passwordInput.value)?.focus()
    return
  }

  isSubmitting.value = true

  try {
    await login({ username: username.value.trim(), password: password.value })

    const redirect = route.query.redirect
    const destination =
      typeof redirect === 'string' && /^\/(?!\/)/.test(redirect)
        ? redirect
        : '/'

    await router.replace(destination)
  } catch (error) {
    if (isAxiosError(error) && error.response?.status === 401) {
      formMessage.value = 'El usuario o la contraseña no son correctos.'
    } else if (isAxiosError(error) && error.response?.status === 400) {
      formMessage.value = 'Revisa los datos e intenta nuevamente.'
    } else {
      formMessage.value =
        'No fue posible iniciar sesión. Verifica tu conexión e intenta nuevamente.'
    }
  } finally {
    isSubmitting.value = false
  }
}
</script>

<template>
  <main class="auth-layout">
    <section class="institution-panel" aria-labelledby="institution-title">
      <div class="institution-copy">
        <p class="institution-name">Tecnológico Nacional de México</p>
        <h1 id="institution-title">Acceso institucional</h1>
        <p>
          Ingresa con las credenciales asignadas para continuar a la plataforma.
        </p>
      </div>
      <p class="institution-note">Identidad segura. Sesión protegida.</p>
    </section>

    <section class="auth-workspace" aria-labelledby="login-title">
      <div class="auth-form-wrap">
        <div class="section-heading">
          <p>TecNM</p>
          <h2 id="login-title">Iniciar sesión</h2>
          <p>Escribe tus datos de acceso.</p>
        </div>

        <form :aria-busy="isSubmitting" novalidate @submit.prevent="submit">
          <div class="field-group">
            <label for="username">Usuario</label>
            <input
              id="username"
              ref="usernameInput"
              v-model="username"
              name="username"
              type="text"
              autocomplete="username"
              autocapitalize="none"
              spellcheck="false"
              required
              :aria-invalid="Boolean(usernameError)"
              :aria-describedby="usernameError ? 'username-error' : undefined"
              :disabled="isSubmitting"
              @input="clearUsernameError"
            />
            <p v-if="usernameError" id="username-error" class="field-error">
              {{ usernameError }}
            </p>
          </div>

          <div class="field-group">
            <label for="password">Contraseña</label>
            <input
              id="password"
              ref="passwordInput"
              v-model="password"
              name="password"
              type="password"
              autocomplete="current-password"
              required
              :aria-invalid="Boolean(passwordError)"
              :aria-describedby="passwordError ? 'password-error' : undefined"
              :disabled="isSubmitting"
              @input="clearPasswordError"
            />
            <p v-if="passwordError" id="password-error" class="field-error">
              {{ passwordError }}
            </p>
          </div>

          <p
            class="form-message"
            :class="{ 'form-message--status': isSubmitting }"
            aria-live="polite"
            aria-atomic="true"
          >
            {{ isSubmitting ? 'Verificando credenciales…' : formMessage }}
          </p>

          <button class="primary-action" type="submit" :disabled="isSubmitting">
            {{ isSubmitting ? 'Ingresando…' : 'Ingresar' }}
          </button>
        </form>
      </div>
    </section>
  </main>
</template>
