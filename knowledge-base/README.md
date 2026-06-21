# Knowledge Base — what to upload as grounding

The agent writes better when grounded on **real, labeled** material. Upload the following into
Copilot Studio **Knowledge**. Keep it curated and small — quality over quantity.

## 1. The engine docs (this repo)
- `docs/02-lor-types.md`, `docs/03-document-anatomy.md`
- `agent/generation-prompts/00-shared-style-guide.md` + `type-A/B/C/D`
- `agent/qa-review-rubric.md`, `agent/intake-spec.md`

## 2. The official template
- `PDG-CMG-063-TMP R1.0` (Carta de Recomendación – Contratos), the empty form, so the agent
  knows the exact section order, header block and footer.

## 3. Gold examples — 1–2 per type, **labeled by type**
Pick the cleanest signed LORs you have. Label each clearly (filename or a header line) with its
type so the agent retrieves a **matching** example, not a random one.

| Type | Good candidates from your Drive |
|---|---|
| **C — Change Order / Adenda** | `SP25017 ... Carta de recomendación (LOR)`, `LOR Change Order 02/03/04`, `LS23135 FloSolutions LOR Adenda 005`, `C502 - LOR Change Order 01` |
| **A — Competitive** | a new‑award LOR with a real multi‑proponent evaluation (e.g. an `SP25007`/`SP25039` award if it was competitive) |
| **B — Single source** | a sole‑bidder award LOR (single quote, justification) |
| **D — Renewal/Extension** | a term‑extension LOR, if you issue them; else omit and merge into C |

> ⚠️ **De‑identify if needed.** These contain supplier names, prices and signatories. Keep them
> in the governed Contracts environment; don't expose the agent or its knowledge outside the
> authorized security group.

## 4. Reference data (optional but useful)
- The **DOA matrix** (roles ↔ amount thresholds) — as data behind the flow (env var), and/or as
  a knowledge page so the agent can tell the user which signatories will appear.
- A short **glossary**: Trend (`ZP_xxxx`), control account format (`6000.4B00.CM_xxxx`),
  Unifier, Anexo 01 (propuesta/partidas), Anexo 02 (budget analysis), I.G.V.

## How the agent uses this
1. After classifying the type, it retrieves the **template + the same‑type gold example(s)**.
2. It uses them for **format and tone only** — the system prompt forbids copying their content
   or their case logic.
3. It writes the current case from the user's facts, then runs the rubric.

## Maintenance
- When a particularly good LOR is signed, add it as a new gold example and retire a weaker one.
- Keep ~1–2 examples per type; too many dilute retrieval and increase the chance the agent
  over‑anchors on one case.
