# Single-file prototype implementation

## Required structure

```html
<!doctype html>
<html lang="tr">
  <head>
    <!-- metadata, fonts, Tailwind browser CDN, optional pinned dependencies -->
    <style type="text/tailwindcss">/* theme + utilities */</style>
    <style>/* non-Tailwind CSS and fallbacks */</style>
  </head>
  <body>
    <!-- semantic page -->
    <script>/* small vanilla interactions */</script>
    <script type="module">/* optional pinned Motion imports */</script>
  </body>
</html>
```

## Dependency decision

- Tailwind browser CDN: default prototype styling layer.
- Vanilla JS: default interaction layer.
- Lucide: only if a consistent icon system is needed.
- Alpine: only when declarative state materially simplifies the file.
- Motion: only when CSS/WAAPI cannot express the intended interaction cleanly.

## Quality

- Use semantic landmarks.
- Include `aria-expanded`, `aria-controls`, labels, and focus management where relevant.
- Keep copy real and product-specific.
- Add a `prefers-reduced-motion` fallback.
- Do not leave console errors or dead buttons.
