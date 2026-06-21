# Power Automate — Render & Route Flow ("Renderizar LOR")

Power Automate's job in v2 is **plumbing only**: take the model‑written document and turn it into
the official Word/PDF, store it, register it, and route it for approval. **It never authors or
edits prose.**

> If you previously had a flow that built the document text with `concat()`/`replace()` from a
> JSON of fields — that is the part being deleted. The text now arrives already written.

## Trigger
- **"When an agent calls the flow"** (Copilot Studio action), or an instant/HTTP trigger.
- Inputs:
  - `cuerpo_markdown` (string, multiline) — the full document body (## per section).
  - `meta` (string, JSON) — see [`../agent/intake-spec.md`](../agent/intake-spec.md).

## Steps

### 1. Parse `meta`
- **Parse JSON** → `meta` schema (tipo, contrato_no, numero_cambio, proveedor, monto, moneda,
  numero_lor_sugerido, fecha_recomendacion, control_account, trend, firmantes[], anexos[],
  pendientes[]).

### 2. Assign the LOR number (registry)
- **Dataverse/SharePoint**: get the next number for this contract/type; if `pendientes` is
  non‑empty, mark `Status = BORRADOR`. Use `numero_lor_sugerido` as fallback.
- Create the `LOR_Registry` row (Number, Type, Project, Contract, Supplier, Amount, Currency,
  Status, CreatedBy, CreatedOn).

### 3. Markdown → Word (the render)
Pick one approach (no string concatenation of prose in any of them):

**Option 1 — Word template + content blocks (recommended).**
- Keep `PDG-CMG-063-TMP.docx` with the **fixed chrome** only: header/identification table,
  section heading styles, footer `… PDG-CMG-063-TMP R1.0`, and a single content control / rich
  body region per section (or one "body" content control).
- Convert `cuerpo_markdown` → HTML (a small deterministic mapping: `#→Title`, `##→Heading 1`,
  `###→Heading 2`, `**→bold`, `- →bullet`, markdown tables → HTML tables). Use the **"Markdown to
  HTML"** action (or a tiny Office Script / `html` content control). Insert the HTML into the
  body region with **"Populate a Microsoft Word template"** / Word Online (Business) **"Update
  content control"**.
- Render the **signatory grid** from `meta.firmantes` into the §8 table content control (this is
  structured data, fine to map directly — it's a table, not prose).

**Option 2 — Office Script (most control).**
- An **Office Script** receives `cuerpo_markdown` + `meta`, walks the headings, and writes styled
  paragraphs/tables into a copy of the template. Best fidelity for tables (comparison/budget).

**Option 3 — HTML → PDF only.**
- If a Word deliverable isn't required, convert the HTML to PDF directly (e.g. **"Convert HTML to
  PDF"** / a Graph/3rd‑party action) using a styled CSS that matches the template chrome.

> Whichever option: the **heading order and the §8 grid come from the model output and meta**;
> the flow only applies styles and chrome. The DOA signatory selection logic (which roles by
> amount) can live here as a lookup against the `doa_matrix` env var — that's data, not prose.

### 4. Attach annexes
- If `meta.anexos` references uploaded Anexo 01 / Anexo 02 files, **append** them (Word merge or
  keep as separate PDFs combined at the PDF step). The flow does not generate their content.

### 5. Convert to PDF
- **Word Online (Business) → Convert Word Document to PDF** (or OneDrive convert).

### 6. Store
- Save `.docx` and `.pdf` to `«site_url»/«library_path»/«contrato_no»/` with a deterministic
  name, e.g. `«numero_lor».pdf`. Update the registry row with `DocURL` and `Status`.

### 7. Watermark drafts
- If `meta.pendientes` is non‑empty, stamp **"BORRADOR — PENDIENTE DE DATOS"** and **do not**
  start approval; return the link for completion.

### 8. Route for approval (DOA / Unifier)
- For a final document, start the approval chain selected by amount from `doa_matrix`:
  - If approvals are executed in **Oracle Unifier**, create/notify the Unifier record (API/
    connector or a task/notification to the contracts lead) and set `Status = EN APROBACIÓN`.
  - Otherwise use **Approvals** (sequential, in DOA order) and write back the outcome.

### 9. Return to the agent
- Output `doc_url` (+ `numero_lor`, `status`). The agent shows the user the link.

## What stays OUT of this flow
- ❌ Writing or rewording any section.
- ❌ Deciding the LOR type or the argument.
- ❌ "Filling" narrative placeholders. (There are none — the body arrives written.)

## Failure handling
- If `cuerpo_markdown` is missing a required section heading (1–8) or `meta` fails to parse,
  **fail fast** and return an error to the agent so it fixes the draft — don't render a partial.
- Keep an idempotency key (`numero_lor`) so retries don't create duplicates in the registry.

## Alternative: per‑section generation inside the flow (Option from architecture §"two ways")
If you choose to generate prose in the flow instead of in the agent, insert **AI Builder "Create
text with GPT"** (or Azure OpenAI) actions — one per section — each fed the type prompt + facts,
**before** step 3. The model still writes; the flow still never uses `concat()` for prose. Most
teams should prefer letting the **agent** write (simpler, more Copilot‑native) and keep this flow
purely mechanical.
