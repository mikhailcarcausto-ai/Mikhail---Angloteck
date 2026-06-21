# 01 — Architecture: "Reason‑then‑Write"

## The principle

> **Intelligence authors the document. Plumbing moves it.**
>
> The LLM (inside Copilot Studio) gathers facts, classifies the case, and **writes every
> section as reasoned prose**. Power Automate only **renders** that prose into the official
> Word/PDF template and **routes** it. Power Automate never writes a sentence; the model never
> touches SharePoint.

## End‑to‑end pipeline

```
┌──────────────────────────────────────────────────────────────────────────────┐
│ COPILOT STUDIO AGENT  (the "brain" — see agent/system-prompt.md)              │
│                                                                                │
│  1. INTAKE         Conversationally gather all facts. Don't force a form.      │
│                    Accept pasted emails, eval tables, quotes, budget numbers.  │
│                    Ask only for what's missing for the detected type.          │
│                          │                                                      │
│  2. CLASSIFY       Decide LOR type A/B/C/D (procurement route).                 │
│                    Confirm the type with the user in one line.                 │
│                          │                                                      │
│  3. GROUND         Pull the matching template + 1–2 gold LORs of the SAME type │
│                    from Knowledge (style/format reference, not to copy).        │
│                          │                                                      │
│  4. WRITE          For each section, call the type-specific generation prompt.  │
│                    The MODEL writes full prose, reasoning about THIS case.      │
│                          │                                                      │
│  5. SELF-REVIEW    Run qa-review-rubric.md against the draft. Fix issues.       │
│                    Show the user the full draft in chat for approval/edits.     │
│                          │                                                      │
│  6. HANDOFF        Send the APPROVED full document (structured markdown +       │
│                    a small metadata block) to Power Automate.                   │
└───────────────────────────────────────┬──────────────────────────────────────┘
                                         │  (HTTP / flow action)
┌────────────────────────────────────────▼─────────────────────────────────────┐
│ POWER AUTOMATE  (the "hands" — see flow/power-automate-design.md)             │
│                                                                                │
│  A. RENDER        Map the model's headings/sections into PDG-CMG-063-TMP        │
│                   (Word) preserving styles, signatory table, footers.           │
│  B. ASSEMBLE      Attach Anexo 01 (propuesta) / Anexo 02 (budget) if provided.  │
│  C. CONVERT       Word → PDF.                                                   │
│  D. STORE         Save to SharePoint/Drive in the contract folder; register     │
│                   the LOR in the Dataverse/SharePoint list (number, type, $).   │
│  E. ROUTE         Start the DOA approval (Unifier / Approvals) per amount.       │
└────────────────────────────────────────────────────────────────────────────────┘
```

## The single most important change

**Old hand‑off (lossy):**

```json
{ "supplier": "B&B Murillo SAC", "amount": "203044.03", "scope": "carpas...", "type": "CO" }
```
→ Power Automate pastes these into blanks. The *document* is whatever the template froze.

**New hand‑off (rich):** the agent returns the **entire written body** as structured markdown
plus a thin metadata block used only for file naming, routing and the registry:

```markdown
<!-- METADATA (for the flow only; not printed in the body) -->
meta.tipo: C
meta.contrato: SP25017
meta.proyecto: ZAF001
meta.proveedor: B&B MURILLO SAC
meta.monto_usd: 203044.03
meta.moneda: USD
meta.numero_lor: ZAF001-SP25017-LOR-CO02
meta.firmantes: [Adm. Contratos Sr; Líder Gestión Contratos; Supte. Construcción; Gte. Construcción; Director Proyecto]
<!-- /METADATA -->

# Carta de Recomendación — Orden de Cambio 02

## 1. Recomendación
A continuación se presenta la Carta de Recomendación para la aprobación de la Orden de
Cambio 02 bajo el contrato titulado "…", que se adjudicará a **B&B MURILLO SAC** por un monto
total de **USD 203,044.03** (doscientos tres mil cuarenta y cuatro con 03/100 dólares
americanos), más el I.G.V. correspondiente … *(full reasoned prose continues)*

### 1.1 Alcance general de la Orden de Cambio 02
…

## 2. Estrategia para la adjudicación
*(model argues the route for THIS case)* …

## 3. Análisis del Budget (Anexo 02) …
## 4. Evaluación Técnica …
## 5. Propuesta Económica …
## 6. Conclusión …
## 7. Resumen del Contrato …
## 8. Signatarios …
```

Power Automate now maps **`## 1` → Heading style, body → Normal style**, drops the signatory
matrix, applies the `PDG-CMG-063-TMP R1.0` footer — **pure formatting**. All the *thinking*
already happened upstream, in the model.

## Why this satisfies the constraints

| Constraint | How it's met |
|---|---|
| **"Stop slot‑filling; truly write"** | Sections 1–8 are model‑authored prose, per type. |
| **"Use AI models to fill the text properly"** | Each section is produced by a generation prompt (Copilot Studio generative answers or AI Builder "Create text with GPT" prompt action). |
| **"Adapt to the situation, not a form"** | Type classification + conversational intake + reasoning, not a fixed key map. |
| **"Copilot is mandatory"** | The brain is a published Copilot Studio agent; Power Automate is invoked as a tool. |
| **"Must scale to other users"** | Agent is published to M365 Copilot / Teams; governance, knowledge, and the registry are tenant assets, not one notebook. |

## Component responsibilities (don't blur these)

| Component | Owns | Must NOT do |
|---|---|---|
| **Copilot Studio agent** | conversation, classification, retrieval, **writing**, self‑review | render files, talk to SharePoint directly |
| **Generation prompts** | the *words* of each section, per type | layout, fonts, page numbers |
| **Knowledge base** | templates + gold examples for grounding | be copied verbatim into output |
| **Power Automate** | render → convert → store → route | author or "improve" any sentence |
| **Word template (`PDG-CMG-063-TMP`)** | visual identity, footers, signatory grid | hold logic |
| **Dataverse/SharePoint list** | LOR registry (number, type, amount, status) | — |

## Two valid ways to generate the prose (pick per your licensing)

1. **Copilot Studio native (recommended).** Use the agent's **generative orchestration** with
   the **system prompt** + **knowledge sources**; the agent composes the body and only calls
   Power Automate at the **render/route** step. Simplest, most "Copilot‑native."
2. **AI Builder prompt actions per section.** Power Automate calls **AI Builder "Create text
   with GPT"** (or an Azure OpenAI connector) once per section with the type‑specific prompt,
   then concatenates the *model‑written* sections. Use this if you want the writing to live in
   the flow for governance reasons. **Either way the model writes; never `concat()` prose.**

Both are described concretely in [`flow/power-automate-design.md`](../flow/power-automate-design.md)
and [`flow/copilot-studio-setup.md`](../flow/copilot-studio-setup.md).

## Data & governance (the "scale to others" piece)

- **One Dataverse table `LOR_Registry`** (or a SharePoint list): `LOR_Number`, `Type`,
  `Project`, `Contract`, `Supplier`, `Amount`, `Currency`, `Status`, `DocURL`, `CreatedBy`,
  `CreatedOn`. Gives auto‑numbering, dashboards, and an audit trail.
- **Environment variables** for site URLs, template path, approver matrix — so the same agent
  works across projects without editing prompts.
- **Security roles** so any authorized contracts user gets the agent in Teams/M365 Copilot.
