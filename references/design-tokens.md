# Design tokens: shadcn / tweakcn contract

Build the prototype's theme with the shadcn/ui token contract, the same structure [tweakcn](https://tweakcn.com) exports. It gives you a full light/dark, semantic palette that maps cleanly onto Tailwind utilities. Everything lives inside the single `index.html`.

## Structure inside `index.html`

Put the whole contract in one `<style type="text/tailwindcss">` block, in this order:

1. `@custom-variant dark (&:is(.dark *));`
2. `:root { … }` — light token values as plain CSS custom properties.
3. `.dark { … }` — dark overrides for the same variables.
4. `@theme inline { --color-*: var(--*); … }` — expose the tokens to Tailwind utilities.
5. `@layer base { *{ @apply border-border outline-ring/50; } body{ @apply bg-background text-foreground; } }`

Then style with token utilities: `bg-background`, `text-foreground`, `bg-card`, `text-card-foreground`, `bg-primary`, `text-primary-foreground`, `bg-secondary`, `bg-muted`, `text-muted-foreground`, `border`, `rounded-lg`, `shadow-sm`.

`templates/index.html` already ships this contract as a working skeleton — start from it and replace the token values.

## Browser-CDN rules (verified, non-obvious)

The Tailwind v4 browser runtime (`@tailwindcss/browser@4`) supports `@custom-variant`, `:root`/`.dark`, `@theme inline`, `@layer base`, and `@apply` — including opacity modifiers like `outline-ring/50`. Two rules matter:

- **Never write the tailwindcss `@import` directive text in this block — not even inside a comment.** The runtime already bundles Tailwind's core; the literal presence of that exact directive string silently breaks compilation (utilities stop generating) with no console error. Build-time `global.css` files include it; the browser CDN must not.
- **`@theme inline` derived names are not readable plain CSS variables.** `getComputedStyle(...).getPropertyValue('--radius-lg')` returns empty. Use the utility class (`rounded-lg`), not `var(--radius-lg)` in an inline `style`. The underlying `--radius`, `--background`, etc. from `:root`/`.dark` remain readable as normal.

## Dark mode

Toggle the `.dark` class on `<html>`. Set it before first paint to avoid a flash, in a script placed in `<head>` **before** the Tailwind runtime script:

```html
<script>
  document.documentElement.classList.toggle(
    "dark",
    localStorage.theme === "dark" ||
      (!("theme" in localStorage) &&
        window.matchMedia("(prefers-color-scheme: dark)").matches)
  );
</script>
```

A visible toggle then flips the class and persists the choice:

```js
const isDark = document.documentElement.classList.toggle("dark");
localStorage.theme = isDark ? "dark" : "light";
```

This honors the OS preference by default and lets the user override it.

## Token set

**shadcn standard** (always define): `background`, `foreground`, `card`(+`-foreground`), `popover`(+`-foreground`), `primary`(+`-foreground`), `secondary`(+`-foreground`), `muted`(+`-foreground`), `accent`(+`-foreground`), `destructive`(+`-foreground`), `border`, `input`, `ring`, `chart-1..5`, `sidebar`(+`-foreground`/`-primary`/`-accent`/`-border`/`-ring`), `radius`.

**tweakcn extensions** (optional, add when the design uses them): `font-sans`/`font-serif`/`font-mono`, `shadow-2xs..shadow-2xl` (and the `--shadow-color/-opacity/-blur/-spread/-offset-*` primitives), `tracking-*`, `spacing`.

Drop `chart-*` or `sidebar-*` only if the prototype has no charts or sidebar. Colors accept both `hsl(...)` and `oklch(...)`; modern shadcn defaults to `oklch`.

## Using a tweakcn export

A tweakcn theme pastes in directly: its `:root`, `.dark`, and `@theme inline` blocks are exactly this contract. Keep the `DESIGN.md` frontmatter `colors` keys in sync with the pasted `:root` variables so the design system and the prototype stay one source of truth.
