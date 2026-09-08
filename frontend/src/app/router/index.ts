import { createRouter, createWebHistory } from 'vue-router'

import { authRoutes } from '../../modules/auth'
import {
  clearSessionMarker,
  hasActiveSession,
} from '../../shared/utils/sessionCookie'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: authRoutes,
})

router.beforeEach((to) => {
  if (!to.meta.requiresAuth) return true

  if (!hasActiveSession()) {
    clearSessionMarker()
    return {
      name: 'login',
      query: { redirect: to.fullPath },
    }
  }

  return true
})

export default router
