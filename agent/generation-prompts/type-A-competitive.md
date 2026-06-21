# Generation Prompt — Type A: Competitive Award (Adjudicación Competitiva)

> Use together with `00-shared-style-guide.md`. The model writes §1–§8 as prose; this file
> tells it **how to argue** the competitive case. Feed the agent the proponent list, criteria,
> scores and price comparison the user provided. Never invent scores or prices.

```
Estás redactando una LOR de tipo ADJUDICACIÓN COMPETITIVA: varios proponentes participaron en
una licitación/RFP y fueron evaluados técnica y económicamente. El argumento central es: "se
condujo un proceso competitivo y justo; aquí está la comparación; el proveedor recomendado es
el de mejor valor (técnico + económico)".

Redacta las 8 secciones. Énfasis por sección:

§1 Recomendación — boilerplate de apertura con proveedor, monto (cifras y palabras), I.G.V.,
base de precios y referencia al Anexo 01. Indica que resulta de un proceso competitivo.
§1.1 Alcance general — alcance completo adjudicado, por zonas/áreas con viñetas; B‑ Cronograma.

§2 Estrategia para la adjudicación — describe la ruta competitiva: cuántos proponentes fueron
invitados y cuántos respondieron, modalidad (RFP/licitación), criterios y su ponderación, y por
qué la competencia es la estrategia adecuada para este alcance/monto. (Solo hechos dados.)

§4 Evaluación Técnica — evaluación técnica REAL: criterios, ponderaciones, puntajes por
proponente, quiénes cumplieron el umbral, descalificaciones y su motivo. Presenta una tabla
comparativa (proponente × criterio/puntaje). Concluye qué proponentes pasaron a evaluación
económica. No rellenes con genérico: usa los puntajes provistos.

§5 Propuesta Económica — comparación comercial multi‑proponente: tabla (proponente × precio,
normalización si aplica, ranking). Explica hallazgos comerciales por proponente y, si
corresponde, el split de responsabilidades del recomendado. Identifica el de menor costo
evaluado y cualquier ajuste de normalización.

§6 Conclusión — "De acuerdo a la Evaluación Técnica y Económica realizada, se recomienda la
adjudicación al postor [X] por lo siguiente:" + razones A./B./C. que combinen mérito técnico Y
económico (no solo "el más barato"): cumplimiento de alcance y capacidad técnica demostrada por
su puntaje; experiencia en servicios similares; mejor valor / propuesta más competitiva y
razonable. Si el recomendado NO es el más barato, justifica el trade‑off explícitamente.

§7 Resumen del Contrato — tabla resumen (proveedor, monto, plazo, base de precios, contrato).
§8 Signatarios — cláusula de autoridad + grilla DOA por monto + nota Unifier.

Reglas: cada afirmación de evaluación debe apoyarse en un puntaje/criterio dado. Si falta el
cuadro de evaluación o los precios, pídelos antes de redactar §4/§5 o márcalos [PENDIENTE].
```

## Minimum facts to have before writing Type A
- Proponentes (invitados vs. respondieron), criterios + pesos, puntajes técnicos, precios por
  proponente, descalificaciones, por qué el recomendado es mejor valor.
