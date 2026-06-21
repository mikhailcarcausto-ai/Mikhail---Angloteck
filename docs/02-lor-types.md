# 02 — The Four LOR Types (the configurable type registry)

A LOR always lives in the same house format (`PDG-CMG-063-TMP R1.0`), but **the argument it
must make changes with the procurement route.** The single biggest reason the old engine felt
"square" is that it tried to argue four different situations with one frozen script.

This file is the **type registry**. The architecture is type‑agnostic — to add, rename, or
merge a type you edit *this table* and add a matching generation prompt under
[`../agent/generation-prompts/`](../agent/generation-prompts/). Nothing else changes.

> ✅ **Confirm / adjust these four.** They are inferred from your real documents
> (`ZAF001_SP25007_LOR` new award; `SP25017 LOR Change Order`, `LOR Change Order 02/03/04`,
> `…Adenda 005` change orders/adendas; single‑source justifications). If your real taxonomy
> differs (e.g. you split "Convenio Marco" or "Emergencia"), rename here and the engine follows.

---

## Quick decision tree (used by the agent to classify)

```
Is this a NEW commitment, or a modification to an EXISTING contract?
│
├─ MODIFICATION of an existing contract ───────────────┐
│     Additional scope / amount / time on a signed      │→  TYPE C — Change Order / Adenda
│     contract (Orden de Cambio, Adenda)                 │
│                                                        │
│     Pure time/term extension, no/again same scope ────┐→  TYPE D — Renewal / Extension (Prórroga)
│
└─ NEW commitment
      │
      ├─ Several proponents were invited & evaluated ───┐→  TYPE A — Competitive Award
      │     (RFP/licitación, technical+commercial score) │
      │                                                  │
      └─ Only one viable supplier / single quote ──────┐→  TYPE B — Single / Sole Source
            (sole source, urgency, proprietary, incumbent)
```

---

## TYPE A — Competitive Award (Adjudicación Competitiva / Licitación)

**When:** an RFP/licitación where **two or more proponents** submitted offers and were
evaluated technically and commercially.

**The argument to make:** *"We ran a fair competitive process; here is the comparison; the
recommended supplier is the best‑evaluated/best‑value."*

**What MUST appear (beyond the shared anatomy):**
- §2 Estrategia: the competitive route, how many were invited/responded, evaluation method.
- §4 Evaluación Técnica: **real technical evaluation** — criteria, weights, scores, who passed.
- §5 Propuesta Económica: **multi‑proponent commercial comparison** (table: proponent ×
  price, normalization, ranking), commercial findings per proponent.
- §6 Conclusión: why the recommended one wins on **combined technical + commercial** merit —
  not just "cheapest", but best value, with the trade‑offs named.

**Inputs that matter most:** list of proponents, technical scores, price table, evaluation
criteria/weights, any disqualifications, budget reference.

---

## TYPE B — Single / Sole Source (Fuente Única / Postor Único)

**When:** only **one** supplier quoted or is viable — incumbent, proprietary technology,
urgency, market of one, or strategic continuity.

**The argument to make:** *"Competition was not run (or not possible); here is the legitimate
justification, and the single offer is fair and reasonable."*

**What MUST appear:**
- §2 Estrategia: **explicit justification of the single‑source route** (the heart of this type).
- §4 Evaluación Técnica: typically a **waiver statement** with reason (e.g. existing contract,
  proprietary scope) — argued, not blank.
- §5 Propuesta Económica: **price reasonableness** evidence — benchmark vs. budget/estimate/
  historical rate, the responsibility split (A cuenta del Proponente / A cuenta del CMZ).
- §6 Conclusión: scope fit + experience + reasonable price; **why sole‑source is in CMZ's
  interest** and not a governance gap.

**Inputs that matter most:** the sole‑source reason, the single quote, a price benchmark, the
responsibility split, budget coverage.

> The real `SP25017` LOR in [`03-document-anatomy.md`](03-document-anatomy.md) is essentially a
> Type B argument applied inside a change order — see Type C for the overlap.

---

## TYPE C — Change Order / Adenda (modification of an existing contract)

**When:** additional scope, amount and/or time is added to a **signed contract** via Orden de
Cambio / Adenda (e.g. `SP25017` Adenda 01; `Change Order 02/03/04`).

**The argument to make:** *"The base contract exists; this added scope arose; amending it is
faster/cheaper/lower‑risk than a new tender; here's budget coverage and the reasonable price."*

**What MUST appear:**
- Header/title carries the **change number** consistently (a real failure case was "OC 02" in
  the title but "OC 01" in the body — the QA rubric explicitly checks this).
- §1.1 Alcance: **the additional scope only**, broken out by zone/área with bullets + plazo.
- §2 Estrategia: why **amend vs. re‑tender** (continuity, mobilized contractor, schedule).
- §3 Análisis del Budget (Anexo 02): **budget impact** — original vs. revised vs. forecast,
  the funding Trend (e.g. `ZP_4109`), delta under/over budget, control account.
- §4 Evaluación Técnica: usually **waived because of the existing contract** — argued.
- §5 Propuesta Económica: unit‑price basis per Anexo 01; responsibility split.
- §6 Conclusión: scope fit, incumbent experience, reasonable price.

**Inputs that matter most:** base contract no., change number, added scope by zone, added
amount, Trend/funding, budget before/after, control account, Anexo 01 (partidas) & 02 (budget).

---

## TYPE D — Renewal / Extension (Renovación / Prórroga)

**When:** extending the **term/period** of an existing contract (with or without a value
adjustment), without materially new scope — e.g. a services contract whose period is extended.

**The argument to make:** *"The contract performed well; continuity is justified; the extended
term and any price adjustment are reasonable."*

**What MUST appear:**
- §2 Estrategia: justification for continuity vs. re‑tender (performance, transition risk/cost).
- §4 Evaluación Técnica: **performance to date** of the incumbent (KPIs, compliance, HSE).
- §5 Propuesta Económica: the extended value / rate, any escalation, vs. market/budget.
- §6 Conclusión: performance + continuity value + reasonable terms.

**Inputs that matter most:** base contract, new term/dates, performance record, value/rate
adjustment, budget coverage.

> If you don't actually issue renewal LORs, **merge D into C** (an extension is a change order
> on the term) and keep three types. The engine doesn't care — it reads this registry.

---

## Type → generation prompt map

| Type | Name | Argument core | Generation prompt |
|---|---|---|---|
| **A** | Competitive Award | comparison + best value | [`type-A-competitive.md`](../agent/generation-prompts/type-A-competitive.md) |
| **B** | Single / Sole Source | justify no competition + price reasonableness | [`type-B-single-source.md`](../agent/generation-prompts/type-B-single-source.md) |
| **C** | Change Order / Adenda | amend vs. re‑tender + budget impact | [`type-C-change-order.md`](../agent/generation-prompts/type-C-change-order.md) |
| **D** | Renewal / Extension | performance + continuity | [`type-D-renewal-extension.md`](../agent/generation-prompts/type-D-renewal-extension.md) |

All four share the section skeleton and house style in
[`03-document-anatomy.md`](03-document-anatomy.md) and
[`../agent/generation-prompts/00-shared-style-guide.md`](../agent/generation-prompts/00-shared-style-guide.md).
They differ **only** in how §2/§4/§5/§6 are argued — which is exactly what the old single
template could not express.
