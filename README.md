# LOR Generation Engine v2 — "Reason‑then‑Write"

A redesign of the **Letter of Recommendation (LOR / Carta de Recomendación)** generator
for the Zafranal / Teck contract‑award process, built on **Microsoft Copilot Studio +
Power Automate**.

> **LOR = Carta de Recomendación (Contratos)** — the document that justifies and authorizes
> the award (or change order) of a contract to a supplier after a tender/evaluation, routed
> for approval through the DOA matrix in Oracle Unifier. Template of record:
> `PDG-CMG-063-TMP R1.0`.

---

## Why this v2 exists

The current build is **"square"**: a Copilot agent collects a few fields, hands a **JSON**
object to Power Automate, and Power Automate **fills placeholders** in a Word template. The
agent has the final template and one example, so it *imitates the shape* but it **does not
actually write the document** — it fills blanks. The result reads like a form, not a
reasoned recommendation, and it cannot adapt when the situation differs from the example
(competitive vs. single‑source, new contract vs. change order, partial scope, split
responsibilities, budget overruns, etc.).

**Root cause:** the *writing* was delegated to **string concatenation in Power Automate**
instead of to an **AI model**. JSON slot‑filling is deterministic plumbing; it can place a
name in a blank, but it cannot argue an award justification.

## What v2 changes (one sentence)

> **The AI model writes the entire document, section by section, reasoning about the specific
> situation; Power Automate is demoted to plumbing** (collect data → render the
> model's prose into the official Word/PDF template → save → route for signature).

This is the **"reason‑then‑write"** pattern. See [`docs/01-architecture.md`](docs/01-architecture.md).

---

## What's in this repository

```
README.md                         ← you are here
docs/
  00-problem-and-diagnosis.md     Why the current flow produces low-quality output
  01-architecture.md              The reason-then-write architecture (with diagrams)
  02-lor-types.md                 The 4 LOR types and how each is argued differently
  03-document-anatomy.md          Canonical LOR section anatomy (from real signed docs)
agent/
  system-prompt.md                Copilot Studio agent instructions (orchestration brain)
  intake-spec.md                  Conversational intake: what to collect, per type
  generation-prompts/
    00-shared-style-guide.md      House style, tone, boilerplate, number/format rules
    type-A-competitive.md         Writing prompt: competitive award (multi-proponent)
    type-B-single-source.md       Writing prompt: single / sole-source award
    type-C-change-order.md        Writing prompt: change order / adenda
    type-D-renewal-extension.md   Writing prompt: renewal / extension (prórroga)
  qa-review-rubric.md             Self-critique checklist the agent runs before output
flow/
  copilot-studio-setup.md         Step-by-step: build the agent in Copilot Studio
  power-automate-design.md        The new flow that renders + routes the document
knowledge-base/
  README.md                       What to upload as grounding (templates + gold examples)
```

## How to read this kit (recommended order)

1. **[`docs/00-problem-and-diagnosis.md`](docs/00-problem-and-diagnosis.md)** — understand the failure.
2. **[`docs/01-architecture.md`](docs/01-architecture.md)** — understand the fix.
3. **[`docs/02-lor-types.md`](docs/02-lor-types.md)** + **[`docs/03-document-anatomy.md`](docs/03-document-anatomy.md)** — the domain.
4. **[`agent/`](agent/)** — the actual prompts you paste into Copilot Studio.
5. **[`flow/`](flow/)** — wire the agent and the rendering flow.

## Status of assumptions to confirm

- **The 4 LOR types** (A competitive / B single‑source / C change‑order / D renewal) are
  inferred from your real documents. They are a **configurable registry** — rename, merge, or
  add a 5th in [`docs/02-lor-types.md`](docs/02-lor-types.md) without touching the architecture.
- Everything here targets **Copilot Studio (custom/declarative agent) + Power Automate +
  Word/SharePoint + Unifier**, per the "Copilot is mandatory" and "must scale to other users"
  constraints.
