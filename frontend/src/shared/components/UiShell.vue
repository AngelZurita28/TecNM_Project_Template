<script setup lang="ts">
withDefaults(defineProps<{ showHeader?: boolean; showSidebar?: boolean }>(), {
  showHeader: true,
  showSidebar: true,
})
</script>

<template>
  <div class="app-shell">
    <slot v-if="showHeader" name="header" />
    <div class="layout" :class="{ 'layout--content-only': !showSidebar }">
      <slot v-if="showSidebar" name="sidebar" />
      <main id="inicio" class="ui-main"><slot /></main>
    </div>
    <footer v-if="$slots.footer" class="ui-footer"><slot name="footer" /></footer>
  </div>
</template>

<style scoped>
.app-shell { min-height: 100dvh; display: flex; flex-direction: column; }
.layout {
  --sidebar-width: 216px;
  width: 100%;
  max-width: none;
  margin: 0;
  flex: 1;
  grid-template-columns: var(--sidebar-width) minmax(0, 1fr);
}
/* El límite sigue en el contenido; sidebar ocupa el borde de la ventana. */
.ui-main {
  width: 100%;
  max-width: calc(1600px - var(--sidebar-width));
  margin-inline: auto;
}
.layout--content-only > .ui-main { max-width: 1600px; }
@media (max-width: 1100px) {
  .layout { --sidebar-width: 180px; }
}
@media (max-width: 640px) {
  .ui-main { max-width: none; }
}
.layout--content-only { grid-template-columns: minmax(0, 1fr); }
</style>
