# Playbook — C&P Process Tracking & Weekly Critical-Processes Report

Mikhail runs Contracts & Procurement (C&P) processes for the Zafranal Project (ZAF001,
Compañía Minera Zafranal S.A.C. / Teck). Every week (cut-off **Thursday**) he updates:

- `Process_Calendars_Wide_<yyyy-mm-dd>_vNN.xlsx`, the master tracker (one row per process);
- `WeeklyReport_CriticalProcesses_<yyyy-mm-dd>_vNN.pptx`, "Contracts & Procurement Plan
  Progress Report", in English.

## The process model

Milestones, in order (each has **Plan / Forecast / Actual**):

| # | Milestone | Notes |
|---|---|---|
| 1 | SoW | Scope of Work received from Engineering/Owner (often Ausenco) |
| 2 | Contracting Strategy | NA for addenda |
| 3 | RFP issued | Unifier EC / RFP numbers when available |
| 4 | Bids / Proposals received | |
| 5 | LOR approved | Carta de Recomendación (see `documents-qa.md`) |
| 6 | LNTP / Contract / CHO signed | |
| 7 | Mobilization | |
| 8 | Execution start | |

Row metadata: Workstream · Process code (`SPyyNNN`) · Process · Specialist (initials,
e.g., MC, RP) · Strategy (Competitive tender / Addendum) · Size · Status · Current milestone ·
Δ Current · Δ Award · Δ Start · Comment.

**Variance** = `Plan − Forecast` (or `Plan − Actual` once done), in calendar days; negative =
delay.
Traffic light: 🟢 On time · 🟡 Delay ≤ 7 d · 🟠 8–14 d · 🔴 > 14 d.

## Weekly update procedure (Android runs this when asked "actualicemos el reporte")

1. **Load** the latest tracker (highest `vNN`; if several copies like `v39 (1)`, `v39 (3)`,
   use the most recently modified and **say which one**).
2. **Collect changes since last week** from email/notes: new forecast dates, actuals,
   who said what ("per <contractor contact>'s email").
3. **Recompute** variances and traffic lights for every row. Flag any row where the stored Δ
   doesn't match the recomputed value.
4. **Consistency checks** (report every hit under "⚠️ Alertas"):
   - forecast dates in milestone order (SoW ≤ Strategy ≤ RFP ≤ … ≤ Execution);
   - Excel row ⇄ PPT slide (same dates, same comment, same strategy);
   - Executive summary table ⇄ detail slides;
   - **external commitments ⇄ tracker:** any date promised by email to a user area or
     contractor that the tracker no longer supports → propose a revised-calendar email;
   - strategy changes (e.g., a competitive tender that became an addendum), so update the
     strategy column, the slide subtitle and any open EOI/precalification communications;
   - completed rows have Actuals in every applicable milestone.
5. **Write comments** in the report's house style: dated header ("Thursday 29-Oct-26"),
   short factual lines, past tense for facts, "forecast" for projections, cause of delay
   when known ("Delay driven by Trend approval wait."), and a last line "Delayed." when
   red/orange.
6. **Bump the version** (`vNN+1`), keep date in filename = cut-off date.
7. **Deliver:** list of changes (row · field · old → new) for Mikhail to paste, or the
   updated files if file tools are available. Never overwrite the previous version.

## Look-ahead (used by the daily brief)

For each row, list milestones with forecast in [today, today + N working days], plus any
milestone whose forecast is **already past without an Actual** ("vencido sin actual").
