# Playbook — Contract Documents: Drafting & Cross-checking

## LOR (Carta de Recomendación, PDG-CMG-063-TMP R1.0)

Use the **LOR Generation Engine v2** already in this repository. It is the source of truth
for types A/B/C/D, anatomy, style and QA:

- `../../../../agent/system-prompt.md`: workflow (intake → type → grounding → write → QA)
- `../../../../agent/generation-prompts/`: shared style guide + type prompts
- `../../../../agent/qa-review-rubric.md`: the self-review checklist

Android adds the cross-checks below **before** a LOR goes to signature.

## LOR ⇄ Budget Analysis (BA) reconciliation

The BA summary has **A. Control Budget** (A1 Original … A5 Current Budget, A7 EAC, A9 Total
Forecast) and **B. PO** (B1 Awarded, B2 Approved Changes, B3 This change, B4 New Contract
amount, B6 Forecast). Check:

| Check | Rule |
|---|---|
| This change | LOR amount (sin IGV) **=** BA B3 |
| New contract value | LOR "valor actualizado" **=** BA B4 = B1 + B2 + B3 |
| Prior value | LOR previous value = B1 + B2 |
| Budget headroom | B4 (or B6) **≤** A7 EAC. If not: name the gap in USD and ask whether a **Trend** is approved/pending (cite the trend ID if known) |
| BA is current | BA notes/title refer to the **same CHO number** as the LOR (a BA still describing the previous CHO is a red flag) |
| Words = figures | Amount in words matches figures; currency and I.G.V. stated |
| Term | Plazo in LOR = contract/CHO term; say "no modifica el plazo" explicitly if unchanged |

Report as: ✅ ok / ⚠️ mismatch, with both values and the difference.

## Itemizado (pricing breakdown) ⇄ LOR

- Sum of partials = LOR amount; quantities × unit prices = partials (recompute).
- Scope split (Alcance 1 / Alcance 2) matches the LOR scope section.

## TdR / SoW (Términos de Referencia)

Checklist before issuing to bidders:
- document number assigned (`ZAF-001-SC-TDR-XXXX` → real number);
- term (plazo) validated with the user area;
- site visits, penalties, deliverables and payment milestones defined;
- SSOMA (HSE) annexes of CMZ attached;
- annexes A–E referenced exist; revision letter (Rev. A internal → Rev. 0 issue).

## Contractor observations log (e.g., CN-xxx)

Table `N.º | Observación | Comentario <Contratista> – Referencia Propuesta | Acción TECK`.
Android drafts "Acción TECK" as clear, single-owner actions with a due date, and makes sure
no observation blocks a deliverable date unless that's intended ("Este punto no debe
limitar la entrega de la propuesta el lunes.").

## Precalification / EOI

Template `PDG-CMG-070-TMP` (Prequalification Evaluation). Android can prepare: bidder long
list with full legal names, key equipment list, EOI/NDA/questionnaire calendar, and the
user-area confirmation email (see `email-style.md`).
