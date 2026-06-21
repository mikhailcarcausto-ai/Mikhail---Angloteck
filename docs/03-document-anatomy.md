# 03 — Canonical LOR Anatomy

Reverse‑engineered from real signed LORs (e.g. `SP25017 Carta de Recomendación (LOR)`,
`ZAF001_SP25007_LOR 01`). This is the **skeleton every type fills**; the *argument* inside the
sections is what changes by type (see [`02-lor-types.md`](02-lor-types.md)).

> Template of record: **`PDG-CMG-063-TMP R1.0`** — "Carta de Recomendación (Contratos)".
> Footer on every page of the core LOR: `Carta de Recomendación (Contratos) — Revision 0 —
> Página X de N — PDG-CMG-063-TMP R1.0`.

## Format facts (load‑bearing — the renderer must preserve these)

- **Language:** Spanish (Peru), formal procurement register, impersonal third person
  ("Se recomienda…", "Se está procediendo…").
- **Document is an internal recommendation FORM**, not a mailed letter: **no postal letterhead,
  no "Estimados señores", no subject/reference salutation.** It opens with a metadata block.
- **Numbering:** sections `1.`, `2.`, … with sub‑sections `1.1`; scope items lettered `A‑`, `B‑`.
- **Approvals:** via the **DOA (Delegation of Authority) matrix** and executed in **Oracle
  Unifier** — *no wet signatures*; the signatory grid lists roles/names with Firma/Fecha.
- **Currency:** USD, "más el I.G.V. correspondiente". Amounts written in figures **and** words
  ("USD 203,044.03 (doscientos tres mil cuarenta y cuatro con 03/100 dólares americanos)").
- **Codes seen:** Project `ZAF001`; Contract `SP25017`; budget control account
  `6000.4B00.CM_1017`; funding Trends `ZP_4023`, `ZP_4109`. (The `ZAF001‑CM‑COR‑xxxxx`
  correspondence code is used for *letters*, not necessarily printed on the LOR form.)

## Header / identification block (top of page 1)

A labeled key/value block — **not** an address:

| Field | Example |
|---|---|
| Título | `Carta de Recomendación — Orden de Cambio 02` (or `… Adjudicación de Contrato`) |
| Nombre del proyecto | Zafranal |
| Proyecto No. | ZAF001 |
| Descripción del contrato | *(full service description)* |
| Contrato No. | SP25017 |
| Dueño | Compañía Minera Zafranal S.A.C. |
| Fecha de recomendación | Noviembre del 2025 |

## Section skeleton (core LOR)

| § | Heading | Purpose | Varies by type? |
|---|---|---|---|
| 1 | **Recomendación** | One‑paragraph opener: what is recommended, to whom, amount (figures+words), basis (precios unitarios per Anexo 01). | Wording, not structure |
| 1.1 | **Alcance general** | Scope, lettered `A‑ …` (by zone, bulleted) + `B‑ Cronograma` (plazo). | Yes (full vs. added scope) |
| 2 | **Estrategia para la adjudicación** | Justify the procurement route. | **Yes — core differentiator** |
| 3 | **Análisis del Budget (Anexo 02)** | Budget coverage / impact; points to Anexo 02. | Yes (impact for C/D) |
| 4 | **Evaluación Técnica** | Technical assessment — real scoring (A) or reasoned waiver (B/C). | **Yes — core differentiator** |
| 5 | **Propuesta Económica** | Price + commercial findings; responsibility split (A cuenta del Proponente / A cuenta del CMZ); multi‑proponent comparison for Type A. | **Yes — core differentiator** |
| 6 | **Conclusión** | "Se recomienda la adjudicación al postor [X] por lo siguiente:" + lettered reasons `A./B./C.` | **Yes — argument** |
| 7 | **Resumen del Contrato** | Compact summary table of the resulting contract. | Mostly values |
| 8 | **Signatarios** | Authority clause + DOA signatory grid; Unifier note. | Roles per amount |
| — | **Anexo 01** | Propuesta Técnica y Económica / Plan de Trabajo + **Plantilla de Partidas** (priced BoQ). | Attached, not authored |
| — | **Anexo 02** | **Budget Analysis – Summary** (English headers, control budget, contract tracking, EDP/CMOD). | Attached, not authored |

### Standard boilerplate strings (reusable, but the model adapts them)

- **Opener (§1):** *"A continuación se presenta la Carta de Recomendación para la aprobación de
  [la adjudicación del contrato / la Orden de Cambio N] titulado «[título]», que se adjudicará a
  [PROVEEDOR], por un monto total de USD [monto] ([monto en palabras]), más el I.G.V.
  correspondiente, … otorgados sobre una base de Precios Unitarios de acuerdo a la estructura
  de costos descrita en el Anexo 01."*
- **§6 opener:** *"De acuerdo a la Evaluación Técnica y Económica realizada, se recomienda la
  adjudicación al postor [nombre] por lo siguiente:"* → `A.`, `B.`, `C.`
- **§8 authority clause:** *"La aprobación de este documento constituirá la autoridad para
  ejecutar [la adjudicación / la Orden de Cambio N] mediante un acuerdo con [proveedor] por un
  monto de USD [monto] ([palabras]), más el I.G.V. correspondiente. Los firmantes incluidos se
  rigen por la Matriz de Aprobación de Documentos aprobada para el valor del compromiso."*
- **§8 Unifier note:** *"Las aprobaciones se realizarán a través de la plataforma de Unifier."*

### Signatory grid (§8) — DOA chain, ascending

Columns: **`Rol | Nombres y Apellido | *Firma / Fecha`**. Typical chain (the set of roles is
selected by commitment amount per the DOA matrix):

| Rol | (ejemplo) |
|---|---|
| Administrador de Contratos Senior | Miguel Ángel Gutiérrez |
| Líder de Gestión de Contratos | Mikhail Carcausto Zea |
| Superintendente General de Construcción | Josías Gómez Fuchs |
| Gerente de Construcción | Carlos Opazo Mondaca |
| Director Proyecto Zafranal | Walter Droppelmann Krebs |

Footnotes: *"\* De acuerdo con las aprobaciones de monto de DOA"* · *"\*\* Las aprobaciones se
realizarán a través de la plataforma de Unifier."*

## Number & formatting rules (the QA rubric enforces these)

- Core LOR amounts: `,` thousands / `.` decimals (`203,044.03`).
- Anexo 02 (budget sheet) often uses European `.`/`,` — **do not "correct" the annex**; keep
  source convention; the LOR body uses the core convention.
- Figures **and** words must agree. Change number must match between **title and body**.
- Placeholders must never ship literally: `XX días`, `00/00/0000`, `Código:`, `Versión:`.

## What the model authors vs. what is attached

- **Authored by the model (the prose):** §1–§8 narrative.
- **Attached / linked, not authored:** Anexo 01 (contractor's priced proposal/BoQ) and Anexo 02
  (budget analysis). The flow attaches them; the model **references** them (§3, §5) but does not
  invent their numbers — it uses figures the user supplied.
