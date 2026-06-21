# QA Review Rubric (the agent runs this on every draft before showing it)

The agent must self‑review the draft against this checklist, fix every ❌, and re‑check, **before**
presenting the document. This step is what stops the inconsistencies that slot‑filling shipped
(e.g. "Orden de Cambio 02" in the title but "01" in the body).

> Tell the agent (in the system prompt, step 5): *"Aplica la rúbrica qa-review-rubric. Para cada
> ítem, responde ✓/❌ internamente; corrige cada ❌ y vuelve a revisar. No muestres el documento
> hasta que todos sean ✓ (salvo [PENDIENTE] de datos que el usuario debe entregar, que se listan
> aparte)."*

## A. Completeness
- [ ] Las 8 secciones existen y tienen prosa (no huecos): 1 (+1.1), 2, 3, 4, 5, 6, 7, 8.
- [ ] §1 incluye proveedor, monto en cifras **y** palabras, moneda, I.G.V., base de precios,
      referencia al Anexo 01.
- [ ] §6 abre con la fórmula estándar y lista razones A./B./C., cada una sustentada por un hecho.
- [ ] §8 incluye cláusula de autoridad + grilla de firmantes (roles por monto) + nota Unifier.

## B. Type fit (¿el argumento corresponde al tipo?)
- [ ] **A Competitiva:** §4 tiene evaluación técnica real (criterios/puntajes) y §5 una
      comparación multi‑proponente; §6 argumenta mejor valor, no solo precio.
- [ ] **B Fuente única:** §2 justifica explícitamente la fuente única y §5 demuestra
      razonabilidad de precio contra una referencia.
- [ ] **C Orden de cambio:** §1.1 es solo alcance adicional; §3 muestra impacto presupuestal
      (original/revisado/forecast, Trend, cuenta de control, delta); §2 justifica adenda vs.
      re‑licitar.
- [ ] **D Renovación:** §4 sustenta desempeño del incumbente; §5 razonabilidad del valor
      extendido.
- [ ] No hay "fuente única disfrazada de competencia" ni viceversa.

## C. Internal consistency (el clásico punto de fallo)
- [ ] El **número de Orden de Cambio / Adenda** es idéntico en título y en TODAS las secciones.
- [ ] El **número de contrato** y el **proveedor** son consistentes en todo el documento.
- [ ] El **monto** es el mismo en §1, §5, §6/§7 y §8 (cláusula de autoridad).
- [ ] El **monto en palabras** coincide exactamente con las cifras.
- [ ] El alcance descrito en §1.1 concuerda con lo recomendado en §6 y el resumen §7.

## D. Numbers & format
- [ ] Cuerpo usa convención `,` miles / `.` decimales (1,234.56).
- [ ] Moneda explícita y "más el I.G.V. correspondiente" donde aplica.
- [ ] Cifras de presupuesto (§3) coinciden con lo provisto por el usuario / Anexo 02 (no
      inventadas).
- [ ] Sin placeholders literales: nada de `XX días`, `00/00/0000`, `Código:`, `Versión:`.

## E. Substantiation (calidad, no formulario)
- [ ] Cada juicio ("más económica y razonable", "experiencia en servicios similares",
      "cumple el alcance") se apoya en un dato concreto que el usuario entregó.
- [ ] No hay afirmaciones genéricas sin respaldo. Donde falte respaldo → `[PENDIENTE]`.

## F. Format/render readiness
- [ ] Un solo `#` H1; secciones `##` (1–8); subsecciones `###` (1.1).
- [ ] Tablas en markdown válido (comparación, presupuesto, resumen, firmantes).
- [ ] Idioma español formal, tercera persona impersonal; sin "yo".

## G. Pendientes report (shown to the user, not in the body)
- [ ] Lista de `[PENDIENTE: …]` con qué dato falta y en qué sección.
- [ ] Lista de **suposiciones** que el agente hizo, para validación del usuario.

---

### Output of the self‑review (internal, then act)
The agent computes a pass/fail per item, fixes fails, and only then presents:
1. The **full document** in chat.
2. A short **"Pendientes y supuestos"** block (G).
3. The question: *"¿Apruebas este documento para generarlo en Word/PDF y enrutarlo, o deseas
   ajustar algo?"*
