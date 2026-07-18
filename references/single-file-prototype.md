# Single-file prototype implementation

## Required structure

```html
<!doctype html>
<html lang="[content language]">
  <head>
    <!-- metadata; anti-flash .dark script BEFORE the Tailwind runtime -->
    <!-- Tailwind browser CDN; optional pinned fonts and dependencies -->
    <style type="text/tailwindcss">
      /* @custom-variant dark; :root + .dark tokens; @theme inline; @layer base */
    </style>
    <style>/* reduced-motion and non-Tailwind fallbacks */</style>
  </head>
  <body>
    <!-- semantic page using token utilities: bg-background, text-foreground, ... -->
    <script>/* small vanilla interactions and theme toggle */</script>
    <script type="module">/* optional pinned Motion imports */</script>
  </body>
</html>
```

Theme with the shadcn/tweakcn token contract; see `references/design-tokens.md`.

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
