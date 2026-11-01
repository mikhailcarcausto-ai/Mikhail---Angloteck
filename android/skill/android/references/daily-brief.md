# Playbook — Daily Brief ("Buenos días")

**Trigger:** "buenos días", "brief", "¿qué tengo hoy?", "morning", or the first message of
the day. Also runs as a scheduled task if one is configured.

## Sources (use whatever is connected; skip silently what isn't)

1. **Google Calendar** (personal account): today plus the next 2 days.
   Include all-day events and recurring personal dates.
2. **Gmail**, last 48 h, excluding promotions/social:
   - unread mail from real people, or mail marked important;
   - anything Mikhail **sent** to his Teck address (`@teck.com`). These are work drafts or
     commitments, so treat them as open loops;
   - bills and due dates (phone/internet, cards, utilities), bookings, course purchases.
3. **Google Drive**, files modified in the last 72 h, especially the working folder holding
   the weekly report, the process calendar, LORs, BAs and contractor observations.
4. **Memory**: the private profile (key dates, people, open loops, goals).
5. **C&P tracker**: latest `Process_Calendars_Wide_*.xlsx` / `WeeklyReport_CriticalProcesses_*.pptx`.
   Pull every milestone whose **forecast** falls today → +3 working days.

> Work calendar (Teck Outlook/Teams) is not connected. If Mikhail pastes it, use it;
> otherwise say "No veo tu agenda de Teck. Si me la pegas, la cruzo."

## Output format (Spanish by default, ≤ 1 screen on a phone)

```
Buenos días, Mikhail ☀️  [día, fecha]

🎯 Lo único que importa hoy
<one sentence: the single highest-consequence item and why>

📅 Agenda
- hh:mm  Evento (nota breve si aplica)

🏗️ C&P: hitos próximos (hoy → +3 días hábiles)
- dd-mmm  SPxxxxx · Hito (P: dd-mmm / F: dd-mmm, var. −N d) → acción sugerida

✉️ Por responder / compromisos abiertos
- Persona · tema · desde cuándo · próximo paso

⚠️ Alertas (inconsistencias o riesgos detectados)
- …

❤️ Vida
- fechas especiales, tu esposa, pagos con vencimiento, salud/descanso

👉 Mi sugerencia
<one concrete next action Android can do right now, e.g., "¿Te dejo listo el borrador a X?">
```

## Rules

- **Prioritise by consequence, not by recency.** A supplier proposal due today beats ten
  newsletters.
- **Ignore noise:** promotions, LinkedIn job alerts (unless Mikhail has said he's looking),
  product newsletters. Summarise them as one line at most ("+12 promocionales ignorados").
- **Weekends:** keep it to Vida + a short "Lo que viene el lunes". Don't push work on Sunday
  unless something is due Monday morning.
- **Variance convention:** `var = Plan − Forecast` in days; negative = delay. Traffic light:
  🟢 on time · 🟡 ≤ 7 d · 🟠 8–14 d · 🔴 > 14 d.
- **Dates:** `dd-mmm` in Spanish (`02-nov`) in the brief; `dd-Mmm-yy` (`02-Nov-26`) when
  quoting the English report. Timezone America/Lima.
- If a source fails, say which one in one line. Don't make up its contents.
