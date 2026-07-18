---
version: alpha
name: "[Project design system]"
description: "[One-sentence design thesis]"
# Color keys follow the shadcn/tweakcn contract and map 1:1 to the
# :root / .dark CSS variables in index.html. Both hsl() and oklch() are valid.
colors:
  background: "#FFFFFF"
  foreground: "#111318"
  card: "#FFFFFF"
  card-foreground: "#111318"
  popover: "#FFFFFF"
  popover-foreground: "#111318"
  primary: "#2457F5"
  primary-foreground: "#FFFFFF"
  secondary: "#F2F3F5"
  secondary-foreground: "#20242B"
  muted: "#F2F3F5"
  muted-foreground: "#68707C"
  accent: "#F2F3F5"
  accent-foreground: "#20242B"
  destructive: "#E5484D"
  destructive-foreground: "#FFFFFF"
  border: "#DDE1E7"
  input: "#DDE1E7"
  ring: "#2457F5"
typography:
  sans: "[Body/UI font], sans-serif"
  serif: "ui-serif, Georgia, serif"
  mono: "[Mono font], ui-monospace, monospace"
  display:
    fontFamily: "[Display font]"
    fontSize: 64px
    fontWeight: 600
    lineHeight: 1.0
    letterSpacing: -0.04em
  body:
    fontFamily: "[Body font]"
    fontSize: 16px
    fontWeight: 400
    lineHeight: 1.6
rounded:
  sm: 8px
  md: 14px
  lg: 24px
spacing:
  xs: 4px
  sm: 8px
  md: 16px
  lg: 32px
  xl: 64px
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "#FFFFFF"
    rounded: "{rounded.md}"
---

## Overview

[Audience, emotional response, density, and core visual thesis.]

## Colors

[Roles, contrast, accent discipline, and surface behavior. The frontmatter holds the light `:root` values; document the `.dark` overrides and how they keep WCAG AA contrast, since `index.html` ships both a light `:root` and a `.dark` theme mapped through `@theme inline`.]

## Typography

[Display/body roles, line lengths, weights, and responsive behavior. `sans`/`serif`/`mono` map to `--font-sans`/`--font-serif`/`--font-mono`.]

## Layout

[Container, grid, whitespace, section rhythm, and mobile reordering.]

## Elevation & Depth

[Shadows, borders, tonal layers, or flat hierarchy rules. Map to the `--shadow-*` scale.]

## Shapes

[Radius, line weight, geometry, and image framing. `--radius` drives the `sm/md/lg/xl` scale.]

## Components

[Buttons, navigation, cards, forms, tabs, and states, expressed with shadcn token utilities such as `bg-primary`, `text-primary-foreground`, `bg-card`, and `border`.]

## Do's and Don'ts

- Do: [rule]
- Don't: [rule]

## Imagery and Illustration

[Real screenshots, photography, generated imagery, inline SVG, icon system, and prohibited patterns.]

## Motion

[Purpose, durations, easing, and reduced-motion behavior.]

## Research provenance

- [Source]: [what was adapted]
