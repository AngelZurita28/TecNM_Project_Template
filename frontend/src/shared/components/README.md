# UI institucional

Referencia: `frontend/DESIGN.md`. Ejemplo completo: `modules/auth/views/SessionView.vue`.
Importar desde `shared/components`. Estilos y temas: `shared/styles/global.css`.

- `UiButton`: `variant="primary|accent|secondary|danger"`, `loading`, `disabled`, `type`. Texto mediante slot.
- `UiChip`: `pressed`, evento `click`. Selección controlada por vista.
- `UiField`: `v-model` string, `label`, `error`, `hint`, `as="input|select|textarea"`. `options: { value, label }[]` para select; slot `options` opcional. Atributos nativos al control; método `focus()`.
- `UiToggle`: `v-model` boolean, `label`, `type="checkbox|switch"`.
- `UiRadio`: `v-model` string, `value`, `name`, `label`.
- `UiRange`: `v-model` number, `label`, `min`, `max`; acepta `step` nativo.
- `UiBadge`: `tone="success|warning|danger|info|purple"`.
- `UiAlert`: `tone="success|warning|danger|info"`, `title`, contenido mediante slot.
- `UiDialog`: `v-model` boolean, `title`; slots contenido y `actions`. Escape cierra y devuelve foco.
- `UiToast`: `ref.show(texto)`. Aviso durante 4 segundos; región accesible.
- `UiCard`: `title`, `description`, `metric`, `elevation="card|floating"`; slots contenido y `header`.
- `UiLayout`: `kind="stack|grid|row|fields"`, `as` para elemento semántico.
- `UiShell`: `showHeader`, `showSidebar`; slots `header`, `sidebar`, `footer` y contenido.
- `UiHeader` / `UiSidebar`: `items`, `title`, `subtitle`, `showTitle`, `showLogo`, `logo`. Enlaces `{ label, to }` o grupos `{ label, children }`.
- Layout persistente y configuración: [MainLayout](../../app/layouts/README.md).
- `UiPageHeader`: `title`, `description`, `version`, `eyebrow`.
- `UiText`: `as`, `variant="default|body|display|caption|eyebrow"`.
- `UiMetric`: `label`, `value`, `description`. `UiCallout`: `title` y contenido.
- `UiTable`: `label`, `columns: { key, label }[]`, `rows` con `id`, `selected` opcional. Slots `cell-<key>` reciben `row` y `value`.
- `UiDisclosure`: `title` y contenido. `UiDivider`: separador. `UiTypeSample`: muestra tipográfica.
- `UiColorPalette`: `tokens: { token, label }[]`, `theme`, `compact`. Valores leídos del tema CSS.
- `UiSampleMark`: símbolo original del dummy; no representa logo oficial.

```vue
<script setup lang="ts">
import { ref } from 'vue'
import { UiButton, UiCard, UiField } from './shared/components'
const name = ref('')
</script>

<template>
  <UiCard title="Proyecto">
    <UiField v-model="name" label="Nombre" required />
    <UiButton>Guardar cambios</UiButton>
  </UiCard>
</template>
```

Tema compartido: `useTheme()` expone `dark`; modifica `document.documentElement.dataset.theme`.
Tema inicial según sistema. Sin persistencia ni dependencias nuevas.
