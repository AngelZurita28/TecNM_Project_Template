# Componentes institucionales

Referencia visual: `frontend/DESIGN.md` y `frontend/dummy/index.html`. Conservar colores, tipografía, distribución, radios y elevación.

- Tokens globales claros/oscuros. Tema inicial según sistema; cambio mediante switch.
- Componentes genéricos con props tipadas, slots y eventos Vue. API pública en `index.ts`.
- Cubrir shell, navegación, títulos, tarjetas, disposición, paleta, botones, chips, campos, selección, rango, badges, alertas, métricas, tabla, tipografía, diálogo y feedback.
- Controles con labels, foco visible y estados disabled/error/loading. Diálogo nativo con Escape y restitución de foco.
- Catálogo en SessionView reproduce referencia usando componentes. Datos ilustrativos locales; acciones muestran feedback.
- LoginView dedicada al acceso, con mismos contratos, validación y redirección existentes.
- SessionView conserva datos reales del usuario y logout. Identidad TecNM en ambas vistas.
- Sin dependencias nuevas. Verificar build y muestra responsive en ambos temas.

## Layout persistente

- MainLayout vive en ruta padre autenticada; RouterView cambia únicamente contenido. Login fuera del layout.
- Configuración central: mostrar header/sidebar independientemente; soportar ambos o ninguno.
- UiHeader y UiSidebar separados. Cada uno acepta showTitle/showLogo, título, subtítulo y logo.
- Logo predeterminado: `shared/assets/tecnm-isologo.svg`.
- Navegación acepta enlaces Vue Router y grupos desplegables sin destino propio, con enlaces hijos.
- Desplegables nativos accesibles por teclado; Escape cierra. Estado lateral permanece entre páginas.
- Muestra actual usa ambos componentes y enlaces simples/agrupados. Datos y catálogo permanecen en SessionView.

## Barra lateral en escritorio

- Sidebar al borde izquierdo de ventana, fuera del límite central de 1600 px.
- Mantener posición y ancho actuales del contenido; separar límite del contenido del contenedor exterior.
- Sidebar sticky al hacer scroll, altura de viewport y desplazamiento propio cuando navegación desborde.
- En móvil conservar navegación superior en flujo, sin ocupar viewport completo.
