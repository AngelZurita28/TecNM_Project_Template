# Contexto frontend

## Objetivo

Construir SPA Vue 3 con TypeScript. Primer slice: login local, guard preventivo, sesión visible y logout.

## Lectura obligatoria

1. [Arquitectura frontend](../FRONTEND_ARCHITECTURE.md)
2. [Estándar de autenticación](../AUTH.md)
3. [Contrato canónico de autenticación](../specs/auth.spec.md)
4. [Spec local de Auth](./src/modules/auth/specs/auth.spec.md)

## Reglas

- Aplicar SDD. Actualizar spec antes de código.
- Usar Vue 3, Composition API, `<script setup lang="ts">`, TypeScript y Vite.
- Organizar por vertical slice. Exponer API pública mediante `index.ts`.
- Mantener rutas del módulo en `routes.ts` y cargar vistas de forma diferida.
- Centralizar Axios e interceptores en `src/shared/api/`.
- Usar `withCredentials: true`. Nunca leer ni guardar `auth_token`.
- Usar `session_exp` solo como guard preventivo. API conserva autoridad.
- Usar CSS nativo y tokens semánticos. Mantener formulario accesible y responsive.
- No agregar Pinia ni dependencias sin uso directo.
- Cambiar contrato compartido primero cuando cambie API, cookie, DTO o error.

## Comandos previstos

```bash
npm --prefix frontend install
npm --prefix frontend run dev -- --host
npm --prefix frontend run build
```

Verificación visual prevista: login, error genérico, carga, sesión, logout, redirección por expiración y responsive.

## Mapa

- [`src/app/`](./src/app/): arranque SPA y router agregador.
- [`src/shared/api/`](./src/shared/api/): Axios base e interceptor `401`.
- [`src/shared/styles/`](./src/shared/styles/): tokens y estilos globales.
- [`src/modules/auth/`](./src/modules/auth/): API, tipos, rutas y vistas del slice.
- [`src/modules/auth/specs/`](./src/modules/auth/specs/): contexto frontend de Auth.
- [Contrato raíz](../specs/auth.spec.md): única fuente de verdad compartida.

- [`src/shared/components/`](./src/shared/components/): biblioteca visual reutilizable; [spec](./src/shared/components/specs/components.spec.md).

- [`src/app/layouts/`](./src/app/layouts/README.md): MainLayout persistente; configuración independiente de header, sidebar, marca y navegación.
