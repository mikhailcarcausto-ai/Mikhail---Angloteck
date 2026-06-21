# Intake Specification — what to collect, and the hand‑off format

Two jobs:
1. **Tell the agent what facts each LOR type needs** (so it asks for the minimum, not a form).
2. **Define the exact hand‑off** the agent sends to Power Automate.

## Principle: conversation, not form

The agent should **first absorb whatever the user pastes** (emails, evaluation tables, quotes,
budget sheets) and extract everything it can, **then** ask only for the *missing required*
items for the detected type, grouped into as few questions as possible. Never interrogate.

## Common inputs (all types)

| Field | Required | Notes |
|---|---|---|
| Proyecto / Proyecto No. | ✓ | default `Zafranal` / `ZAF001` (env var) |
| Dueño | ✓ | default `Compañía Minera Zafranal S.A.C.` |
| Descripción del contrato | ✓ | full service description |
| Proveedor recomendado | ✓ | legal name |
| Monto total | ✓ | figure; the agent renders words; state currency + "más I.G.V." |
| Moneda | ✓ | default USD |
| Base de precios | ✓ | precios unitarios / suma alzada |
| Fecha de recomendación | ✓ | month/year |
| Firmantes (roles) | auto | selected by amount from the DOA matrix (env config) |
| Anexo 01 (propuesta/partidas) | if available | attached by flow; referenced in §1/§5 |
| Anexo 02 (budget analysis) | if available | attached by flow; referenced in §3 |

## Type‑specific required inputs

### Type A — Competitive
- Proponentes (lista) and who was invited vs. responded.
- Evaluation criteria + weights; **technical scores**; disqualifications.
- **Commercial comparison**: price per proponent, normalization basis, ranking.
- Why the recommended one is best value (not only cheapest).

### Type B — Single / Sole Source
- **Reason for single source** (incumbent / proprietary / urgency / market of one / continuity).
- The single quote.
- **Price reasonableness** evidence (vs. budget/estimate/historical).
- Responsibility split (A cuenta del Proponente / A cuenta del CMZ).

### Type C — Change Order / Adenda
- Base contract no. + **change number** (must be consistent everywhere).
- **Added scope only**, ideally by zone/área.
- Added amount; new contract running total.
- **Budget impact**: original vs. revised vs. forecast; funding **Trend** (e.g. `ZP_4109`);
  control account (e.g. `6000.4B00.CM_1017`); delta under/over budget.
- Why amend vs. re‑tender.

### Type D — Renewal / Extension
- Base contract; **new term/dates**.
- **Performance record** of incumbent (KPIs, HSE, compliance).
- Value/rate for the extension; escalation if any.
- Budget coverage.

## Validation before writing (agent self‑check)

- All **Required** common fields present (or explicitly `[PENDIENTE]`).
- All **type‑specific required** present for the detected type.
- Amount has a currency and IGV treatment; words can be generated.
- Change number (Type C) captured once and reused.

---

## HAND‑OFF FORMAT (agent → Power Automate action "Renderizar LOR")

Send **two inputs**. The body is the *entire written document*; the meta is *only* for naming,
routing and the registry. **Never** send a flat JSON of fields expecting the flow to assemble
prose — the prose is already written here.

### Input 1 — `cuerpo_markdown` (the full document)

```markdown
# Carta de Recomendación — «título»

## 1. Recomendación
«prosa…»
### 1.1 Alcance general «(de la Orden de Cambio N)»
«prosa…»
## 2. Estrategia para la adjudicación
«prosa…»
## 3. Análisis del Budget (Anexo 02)
«prosa…»
## 4. Evaluación Técnica
«prosa…»
## 5. Propuesta Económica
«prosa… incl. tabla(s) comparativa(s) y split de responsabilidades»
## 6. Conclusión
«De acuerdo a la Evaluación Técnica y Económica realizada, se recomienda… A./B./C.»
## 7. Resumen del Contrato
«tabla resumen»
## 8. Signatarios
«cláusula de autoridad + grilla de firmantes + nota Unifier»
```

Rules for the markdown so the renderer can map it deterministically:
- Exactly one `#` H1 (title). Sections are `##` (`1.`…`8.`), sub‑sections `###` (`1.1`).
- Tables in GitHub‑flavored markdown (renderer converts to Word tables).
- Bold `**…**` and bullets `- ` allowed; no other exotic markup.

### Input 2 — `meta` (routing/registry only)

```json
{
  "tipo": "C",
  "proyecto": "Zafranal",
  "proyecto_no": "ZAF001",
  "contrato_no": "SP25017",
  "numero_cambio": "02",
  "proveedor": "B&B MURILLO SAC",
  "monto": 203044.03,
  "moneda": "USD",
  "igv": "más I.G.V.",
  "numero_lor_sugerido": "ZAF001-SP25017-LOR-CO02",
  "fecha_recomendacion": "Noviembre del 2025",
  "control_account": "6000.4B00.CM_1017",
  "trend": "ZP_4109",
  "firmantes": [
    "Administrador de Contratos Senior",
    "Líder de Gestión de Contratos",
    "Superintendente General de Construcción",
    "Gerente de Construcción",
    "Director Proyecto Zafranal"
  ],
  "anexos": ["Anexo 01 - Propuesta", "Anexo 02 - Budget Analysis"],
  "pendientes": []
}
```

`numero_lor_sugerido` is a suggestion; the flow may overwrite it with the next number from the
`LOR_Registry`. `pendientes` carries any `[PENDIENTE]` items so the flow can watermark the draft
as **BORRADOR** until they're resolved.
