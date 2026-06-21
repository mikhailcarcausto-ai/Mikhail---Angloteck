# 00 — Problem & Diagnosis

## The symptom (in your words)

> "It's quite square… you give some minimum information, the agent has the final output as an
> example and the template… but it is not really generating the text. It's just filling some
> spaces. It's not developing the entire document. Using Power Automate, processing the info
> through JSON, is not delivering a high‑quality document."

That is an exact description of a **slot‑filling** pipeline. It is worth being precise about
*why* it caps out on quality, because the fix follows directly from the diagnosis.

## How the current flow works (reconstructed)

```
User ──chat──> Copilot agent ──JSON──> Power Automate ──fill placeholders──> Word template ──> .docx
                (extracts fields)        (string concat into {{tags}})
```

1. The agent **extracts a handful of variables** from the conversation (supplier, amount,
   contract no., scope blurb…).
2. It emits a **JSON object**.
3. Power Automate maps each JSON key to a **placeholder/content control** in the `.docx`
   template (or builds strings with `concat()` / `replace()`).
4. The filled template is saved.

The agent was *given the final template and one example LOR*, so its output **mimics the shape**
of a finished LOR. But shape ≠ substance.

## Why this structurally cannot produce a high‑quality LOR

| # | Failure mode | Why it happens | What you see |
|---|---|---|---|
| 1 | **No reasoning, only transcription** | The model is used as a *field extractor*, not as a *writer*. The justification narrative (§6 Conclusión, §2 Estrategia, §4 Evaluación) is the hard part of a LOR and it is exactly the part a slot can't hold. | Generic, repeated boilerplate; the "why this supplier" argument is thin or copied from the example. |
| 2 | **The example leaks instead of guides** | With one example in context and "fill the template," the model **anchors on that example's situation** (e.g. a single‑source change order) and reproduces its logic even when the new case is a competitive new award. | Wrong argument type; a competitive tender written as if it were a sole‑source. |
| 3 | **Power Automate writes prose** | `concat()`/`replace()` cannot make a paragraph adapt — it can only paste. Conditional nuance ("scope split between supplier and CMZ", "budget over/under", "technical eval waived because of existing contract") becomes either omitted or a frozen sentence. | Sections that don't fit the case; placeholders left literally unfilled (e.g. `XX días`, `00/00/0000`, `Código:`). |
| 4 | **JSON is a lossy intermediate** | Forcing a rich, narrative situation through a flat key/value JSON **throws away** everything that isn't a pre‑declared field. Anything you didn't model as a key simply disappears. | The document can only ever be as rich as the JSON schema — which is a form. |
| 5 | **One template, four situations** | A LOR for a competitive award argues *scoring and comparison*; a change order argues *additional scope on an existing contract*; a sole‑source argues *why no competition*. One placeholder map can't express four different argument structures. | "It doesn't adapt to the situation." |
| 6 | **No quality gate** | There's no step that checks the draft against what a real LOR must contain. | Inconsistencies ship (e.g. title says "Orden de Cambio 02" but body says "01"). |

> The current design uses the most expensive part of the stack (the LLM) for the *cheapest*
> task (pulling out fields) and the cheapest part of the stack (Power Automate string ops) for
> the *most expensive* task (writing a reasoned legal/commercial document). **It's backwards.**

## The reframe

A LOR is **not a form with blanks**. It is a **short reasoned argument** in a fixed house
format. The variable part isn't just *values* — it's the **argument itself**, which changes
with the procurement route and the facts of the case.

Therefore the engine must:

1. **Understand the situation** (gather facts conversationally, not as a rigid form).
2. **Classify the procurement route** (which of the 4 LOR types → which argument structure).
3. **Retrieve** the right template + 1–2 *matching* gold examples (same type) as **style
   grounding**, not as a thing to copy.
4. **Write each section with the model**, reasoning about *this* case.
5. **Self‑review** against a rubric, then revise.
6. **Render** the finished prose into the official `PDG-CMG-063-TMP` Word/PDF and route it.

Steps 1–5 are *intelligence* (Copilot Studio + model). Step 6 is *plumbing* (Power Automate).
That division is the whole idea, and it's detailed in
[`01-architecture.md`](01-architecture.md).

## Design principles carried through the rest of the kit

- **The model writes the document; the flow moves the document.** Power Automate never
  authors a sentence.
- **Markdown/structured prose is the hand‑off, not JSON.** The model returns the *full written
  body*; the flow maps headings → styled Word, it does not assemble paragraphs.
- **Type‑specific argument, shared house style.** One style guide, four argument modules.
- **Examples are reference, never a cast.** Gold LORs ground tone and format; the agent is
  explicitly told to argue the *current* facts, not the example's.
- **Always end with a QA pass.** No document leaves without passing the rubric.
- **Built to share.** Everything lives in a published Copilot Studio agent governed by the
  M365 tenant, so it scales beyond one user (see [`flow/copilot-studio-setup.md`](../flow/copilot-studio-setup.md)).
