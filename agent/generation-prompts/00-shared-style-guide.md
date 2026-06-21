# Shared Style Guide (applies to all LOR types)

This is grounding the agent uses for **every** section, regardless of type. The type prompts
add the *argument*; this file fixes the *voice and format*.

## Voice
- Español formal de procura, **tercera persona impersonal**: "Se recomienda…", "Se está
  procediendo…", "Se llevó a cabo…". Nunca primera persona ("yo recomiendo").
- Conciso y afirmativo. Sin adjetivos vacíos ni relleno. Cada frase aporta un hecho o un juicio
  sustentable.
- Términos consistentes: "proponente"/"postor", "adjudicación", "alcance", "propuesta
  económica", "I.G.V.", "Precios Unitarios", "Suma Alzada", "Orden de Cambio", "Adenda".

## Hard rules (the QA rubric enforces them)
1. **No inventar datos.** Si falta un dato duro, escribe `[PENDIENTE: descripción]` — nunca un
   número o nombre inventado.
2. **Montos en cifras Y en palabras**, con moneda e I.G.V.:
   `USD 203,044.03 (doscientos tres mil cuarenta y cuatro con 03/100 dólares americanos), más
   el I.G.V. correspondiente`.
3. **Convención numérica del cuerpo:** `,` miles / `.` decimales (1,234.56). No "corregir" los
   anexos si usan otra convención.
4. **Coherencia interna:** el mismo número de Orden de Cambio / contrato / monto en TODO el
   documento, incluido el título.
5. **Sin placeholders literales** en el entregable: nada de `XX días`, `00/00/0000`, `Código:`,
   `Versión:`. (Los `[PENDIENTE]` se listan aparte para el usuario.)
6. **Prosa, no huecos.** Una sección nunca es una lista de campos; es un párrafo argumentado.

## Section conventions (shared skeleton)
- **Títulos** numerados `1.`…`8.`, subsecciones `1.1`. Alcance en ítems con letra `A‑`, `B‑`.
- **§1 Recomendación** abre con el boilerplate:
  *"A continuación se presenta la Carta de Recomendación para la aprobación de
  [la adjudicación del contrato / la Orden de Cambio N] titulado «[título]», que se adjudicará a
  [PROVEEDOR], por un monto total de USD [monto] ([palabras]), más el I.G.V. correspondiente,
  … otorgados sobre una base de [Precios Unitarios/Suma Alzada] de acuerdo a la estructura de
  costos descrita en el Anexo 01."*
- **§1.1 Alcance** se desglosa por zonas/áreas con viñetas y cierra con `B‑ Cronograma` (plazo).
- **§6 Conclusión** abre con:
  *"De acuerdo a la Evaluación Técnica y Económica realizada, se recomienda la adjudicación al
  postor [nombre] por lo siguiente:"* y lista razones `A.`, `B.`, `C.` (cumple alcance + conoce
  el servicio; experiencia en servicios similares; propuesta más económica y razonable — cada
  una sustentada por un hecho del caso).
- **§8 Signatarios** incluye:
  *"La aprobación de este documento constituirá la autoridad para ejecutar [la adjudicación / la
  Orden de Cambio N] mediante un acuerdo con [proveedor] por un monto de USD [monto]
  ([palabras]), más el I.G.V. correspondiente. Los firmantes incluidos se rigen por la Matriz de
  Aprobación de Documentos aprobada para el valor del compromiso."*
  + grilla `Rol | Nombres y Apellido | *Firma / Fecha` (roles según monto/DOA)
  + notas `* De acuerdo con las aprobaciones de monto de DOA` y
    `** Las aprobaciones se realizarán a través de la plataforma de Unifier.`

## Responsibility split (Type B/C, often) — render as two lists under §5
```
• PROPONENTE 1 ([nombre])
  A cuenta del Proponente:
    1. … (pólizas, equipamiento, mantenimiento, movilización, personal calificado,
       beneficios laborales, exámenes médicos, EPPs, alimentación, …)
  A cuenta del CMZ:
    1. … (combustible, alojamiento en site, baños químicos, …)
```

## Tables
- Comparaciones (Type A), resumen del contrato (§7) y presupuesto (§3) en tablas markdown
  simples; el renderer las convierte a tablas Word. Mantén columnas alineadas con los anexos.

## "Sustentación" test (apply to every claim)
Antes de afirmar algo, pregúntate: *¿el usuario me dio el hecho que respalda esto?* Si la
respuesta es no, no lo afirmes: pídelo o márcalo `[PENDIENTE]`. Esto es lo que separa un
documento de alta calidad de un formulario relleno.
