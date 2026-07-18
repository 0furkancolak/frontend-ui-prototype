# frontend-ui-prototype

A shared, question-led, prototype-first frontend skill for Claude Code and Codex.

It turns a product idea, existing app, repository, screenshot, or live URL into a single self-contained `index.html` prototype — after asking the missing product questions, researching a `DESIGN.md` direction, and verifying the result in a browser. It stops at prototype handoff and never silently crosses into production.

The skill's instructions are written in English so it can be installed globally, but it asks questions, writes copy, and responds in the language the user is writing in.

## Default output

The skill does not scaffold a framework project. The default prototype output is:

```text
prototype/<slug>/
├── index.html
├── DESIGN.md
├── Makefile
└── assets/             # only when raster visuals are used
```

- All HTML, CSS, JavaScript, mock data, and inline SVG live in a single `index.html`; selected raster visuals are downloaded into `assets/` and referenced locally (never base64 or remote hotlinks).
- Tailwind CSS is loaded from the browser CDN.
- Theming uses the shadcn/tweakcn token contract (`:root`/`.dark` + `@theme inline`), so a [tweakcn](https://tweakcn.com) export drops in directly, with light/dark support.
- Lucide, Alpine.js, or Motion are added only when genuinely needed, with pinned versions.
- No `package.json`, `node_modules`, Vite, React, Next.js, or build step is created.
- The `Makefile` provides zero-install local serving and validation commands.

## Skill flow

1. Read the current context and repository.
2. Ask at most seven concrete questions for the missing product decisions.
3. If an app exists, extract product truth, routes, screens, visual language, and real features.
4. Research the official Google `DESIGN.md` format and current design-system catalogs.
5. Present three structurally different design directions.
6. The user picks a direction; if they delegate the choice, the skill chooses and justifies it.
7. Create a project-specific `DESIGN.md`.
8. Decide the screenshot, photography, generated-imagery, or illustration strategy.
9. Build the single `index.html`.
10. Verify in a browser at desktop, tablet, and mobile widths, with at least one revision.
11. Stop at prototype handoff.

Research-heavy steps — repository inspection, web research, and screenshot capture — are delegated to parallel subagents when the host supports them.

## Installation

This is a cross-tool skill built on the shared Agent Skills format, installable for both Claude Code and Codex.

```bash
unzip frontend-ui-prototype.zip
cd frontend-ui-prototype
chmod +x scripts/*.sh
make reinstall
```

`make reinstall` removes any old `frontend-ui-prototype` symlinks, validates the package, and reinstalls it for both agents.

Global targets:

```text
~/.claude/skills/frontend-ui-prototype   # Claude Code
~/.agents/skills/frontend-ui-prototype   # Codex
```

> **Codex note:** Agent Skills are a recent Codex CLI feature. Older builds used a different discovery path (`~/.codex/skills/`) behind `codex --enable skills`. If the skill is not detected, verify with `codex --help` or `/skills` and update the Codex CLI.

## Other make targets

```bash
make help
make validate
make install
make install-claude
make install-codex
make reinstall
make uninstall
make clean
make package
```

## Using it in Claude Code

```text
/frontend-ui-prototype
```

Example:

```text
/frontend-ui-prototype
Inspect the existing app. Ask the missing product questions first. Then research suitable DESIGN.md directions from the web and bring them back for selection. After I choose, build the whole prototype as one index.html with CDN packages. Add DESIGN.md and a Makefile. Do not move on to production development.
```

## Using it in Codex

```text
$frontend-ui-prototype
```

Example:

```text
$frontend-ui-prototype inspect the existing app, ask the missing concrete questions, research three suitable DESIGN.md directions, then build the selected direction as one CDN-powered index.html with DESIGN.md and Makefile. Stop at prototype handoff.
```

## Prototype Makefile

Inside the generated prototype folder:

```bash
make serve        # http://localhost:4173
make open
make check
make design-lint
make clean
make reset
```

`make serve` needs no Node or package manager; it uses Python's standard HTTP server.

## Relationship to `frontend-design`

Anthropic's `frontend-design` skill can be used for visual quality and frontend aesthetics. `frontend-ui-prototype` adds the question gate, existing-product inspection, `DESIGN.md` research, visual-evidence strategy, the single-file prototype contract, and browser verification.

## License

MIT © 2026 Furkan Colak. See [LICENSE](LICENSE).
