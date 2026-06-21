# Copilot Studio — Build & Wiring Guide

Step‑by‑step to stand up the agent. Assumes a Power Platform environment with Copilot Studio and
Power Automate, and a SharePoint site (or Drive) for the contract folders.

## 0. Prerequisites
- Copilot Studio license; a Power Platform environment (ideally a dedicated **"Contracts"** env).
- A SharePoint document library, e.g. `Contracts/LOR/` with one folder per contract.
- The official Word template **`PDG-CMG-063-TMP R1.0`** uploaded (see step 5 / power-automate-design).
- Optional but recommended: a **Dataverse table `LOR_Registry`** or a SharePoint list for numbering.

## 1. Create the agent
1. Copilot Studio → **Create → New agent** → name it **"Asistente LOR — Zafranal"**.
2. **Instructions:** paste the block from [`../agent/system-prompt.md`](../agent/system-prompt.md).
3. **Orchestration:** Settings → **Generative orchestration = ON**. (Lets the agent choose
   knowledge/prompts per turn and call the flow as a tool.)
4. **Model:** use the latest available GPT model in your tenant for generation quality.

## 2. Add Knowledge (grounding)
Upload these files as **Knowledge** (the agent references them by name):
- `docs/03-document-anatomy.md`, `docs/02-lor-types.md`
- `agent/generation-prompts/00-shared-style-guide.md` and `type-A/B/C/D`
- `agent/qa-review-rubric.md`, `agent/intake-spec.md`
- **Gold examples**: 1–2 real signed LORs **per type** (see
  [`../knowledge-base/README.md`](../knowledge-base/README.md)). Label each with its type so the
  agent retrieves the matching one.

> Knowledge is **reference**, not a script. The system prompt explicitly forbids copying example
> content; examples ground tone/format only.

## 3. (Optional) Type prompts as Topics/child prompts
If you don't want everything in Knowledge, create a **Topic per type** (A/B/C/D) whose body is
the corresponding generation prompt, triggered after classification. Native Knowledge is simpler;
Topics give tighter control. Either works.

## 4. Add the render flow as an Action/Tool
1. Build the flow in [`power-automate-design.md`](power-automate-design.md) first.
2. In the agent → **Tools → Add a tool → Flow** → select **"Renderizar LOR"**.
3. Inputs the agent passes:
   - `cuerpo_markdown` (multiline text) — the full written document.
   - `meta` (text/JSON) — routing & registry metadata.
4. Output: `doc_url` (link to the generated Word/PDF). The agent returns it to the user.
5. In Instructions (already included), the agent calls this tool **only after** the user approves
   the draft.

## 5. Environment variables (so it scales without editing prompts)
Create environment variables and reference them in the flow (not in the prompt text):
- `site_url` (SharePoint site), `library_path` (e.g. `Contracts/LOR`)
- `template_path` (path to `PDG-CMG-063-TMP.docx`)
- `doa_matrix` (role→amount thresholds) — drives which signatories appear
- `default_project` = `Zafranal` / `ZAF001`, `default_owner` = `Compañía Minera Zafranal S.A.C.`

## 6. Publish & share (the "scale to other users" requirement)
1. **Publish** the agent.
2. **Channels:** enable **Microsoft Teams** and/or **Microsoft 365 Copilot**. Add it to the
   Contracts team.
3. **Security:** grant the Contracts security group access; the agent inherits tenant DLP/governance.
4. Now any authorized contracts user opens the same agent in Teams/Copilot and gets identical
   behavior — no per‑user setup.

## 7. Test matrix (do this before handing it over)
Run one real case per type and verify against the rubric:
- **C — Change Order** using the `SP25017` facts (the digest case): confirm change number is
  consistent, §3 budget impact is present, §1.1 is only added scope.
- **B — Single source**: confirm §2 justification + §5 price reasonableness.
- **A — Competitive**: confirm §4 scoring + §5 multi‑proponent table.
- **D — Renewal**: confirm §4 performance basis.
For each: confirm no literal placeholders, figures=words, and the Word/PDF renders in the
official template with the correct signatory grid.

## 8. Operating loop
User chats → agent gathers, classifies, writes, self‑reviews → shows full draft → user
approves/edits → agent calls **Renderizar LOR** → returns the document link → flow routes for DOA
approval in Unifier/Approvals → registry updated.
