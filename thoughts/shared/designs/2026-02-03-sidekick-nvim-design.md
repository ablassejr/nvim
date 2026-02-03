---
---
date: 2026-02-03
topic: "Sidekick.nvim integration"
status: draft
---

## Problem Statement

We want to integrate **sidekick.nvim** into this LazyVim config to provide **Next Edit Suggestions (NES)** and **AI CLI workflows** directly in Neovim. The goal is a reliable, low-friction experience that aligns with existing AI plugin patterns in this repo.

I'll source configuration options from the **sidekick.nvim README and help docs** (via Context7) and keep the setup minimal but practical.

## Constraints

- Must follow repo conventions: **plugin spec in `lua/plugins`**, with `opts` and **keymaps defined in the spec** (consistent with existing AI plugins).
- Avoid keymap conflicts; prefer **conservative leader-based mappings** over global overrides.
- **NES depends on Copilot LSP**; if it's unavailable, the feature should degrade gracefully.
- **Use E2B for validation** as part of the verification workflow.
- Keep **YAGNI** in mind: only enable options that materially improve UX.

## Approach

I'm choosing **Approach A: curated defaults** based on sidekick’s documented options, with small tweaks that improve usability without overriding existing editor behavior.

**Approach A (chosen):** Minimal config using documented defaults + curated CLI tools + conservative keymaps.
- **Pros:** Low risk, aligns with repo patterns, easy to maintain.
- **Cons:** Leaves some advanced customization unused.

**Approach B:** Heavy customization (custom window layout, extensive keymap overrides, aggressive NES behavior).
- **Pros:** Maximum control.
- **Cons:** Higher risk of conflicts and maintenance.

**Approach C:** Install with defaults only.
- **Pros:** Lowest effort.
- **Cons:** Misses “desirable” CLI and prompt features requested.

## Architecture

We’ll add a **single plugin spec** for sidekick and keep it self-contained.

**Key integration points:**
- **NES integration** with Copilot LSP for next-edit suggestions, inline diffs, and jump/apply behavior.
- **CLI integration** with a terminal window that can launch AI tools and insert prompts/context.
- **Keymap layer** scoped to sidekick actions and aligned with existing AI plugin patterns.

## Components

- **Plugin spec:** Lazy loading, `opts` table, and keymaps colocated (consistent with AI specs in this repo).
- **NES subsystem:** Enablement flags, debounce timing, trigger/clear events, and inline diff mode.
- **Signs & jump list:** Sign icon visibility and optional jumplist integration.
- **CLI subsystem:** Window layout settings, watch mode for external file edits, optional mux backend, and tool registry.
- **Prompts registry:** Curated prompt set for explain/diagnostics/fix/review/optimize/tests.
- **Copilot status tracking:** Optional visibility of Copilot status inside sidekick.
- **Debug logging:** Off by default, enabled only for troubleshooting.

## Data Flow

- **Editing events** trigger NES; sidekick renders inline diffs and signs, then a jump/apply action consumes the suggestion.
- **CLI toggle** opens a terminal for the selected AI tool; prompts can include selection or diagnostics context.
- **External edits** from CLI tools are detected via watch mode to refresh buffers.

## Error Handling

- If **Copilot LSP** isn’t available, NES features should **disable quietly** without breaking the editor.
- If a **CLI tool** is missing, show a non-blocking notification and keep selection open.
- If **mux backend** isn’t present, fall back to non-mux terminals.

## Testing Strategy

- **E2B validation:** Run the E2B workflow to verify the plugin loads, CLI toggle works, and NES doesn’t throw errors.
- **Local sanity:** Headless Lazy sync, then open Neovim to confirm keymaps, signs, and prompt flows.

## Open Questions

- None blocking. If you want a **smaller CLI tool list** or **mux enabled by default**, we can adjust after rollout.
