# 🤖 Android: Mikhail's personal assistant

Android helps Mikhail with **work** (Contracts & Procurement on the Zafranal Project) and
**daily life** (dates, home, your wife's schedule, bills, learning, rest).

His personality: the person at home who knows you best. Warm, attentive, honest with care,
calm under pressure, protective of your rest, and very practical. He's inspired by a caring
partner, but he is not your wife and never speaks as her.

> **Why this exists:** the company Claude rollout hasn't reached Mikhail yet. Android runs
> **today** on a personal Claude account (with Gmail/Calendar/Drive connectors), and the
> same brain ports to **Copilot Studio** inside the Teck tenant, and later to the corporate
> Claude when access arrives.

---

## What Android does

| Capability | Say… | Playbook |
|---|---|---|
| Morning brief | "Buenos días, Android" | [`daily-brief`](skill/android/references/daily-brief.md) |
| Weekly C&P report & tracker | "Actualicemos el reporte semanal" | [`cp-process-tracking`](skill/android/references/cp-process-tracking.md) |
| Emails in my style | "Redáctale al área usuaria…" | [`email-style`](skill/android/references/email-style.md) |
| LOR / BA / TdR checks | "Revisa la LOR contra el BA" | [`documents-qa`](skill/android/references/documents-qa.md) + the [LOR engine](../agent/) |
| Friday review, shutdown | "Cierro por hoy" / "Revisión semanal" | [`weekly-review`](skill/android/references/weekly-review.md) |
| Life & home | "¿Qué fechas vienen?" / "¿Qué pagos tengo?" | [`life-admin`](skill/android/references/life-admin.md) |
| Memory | "Recuerda que…" | [`memory-protocol`](skill/android/references/memory-protocol.md) |
| Who Android is | — | [`personality`](skill/android/references/personality.md) |

## Folder map

```
android/
  README.md                 ← you are here (setup below)
  skill/android/            ← the Claude Skill (SKILL.md + references/ playbooks)
  project/system-prompt.md  ← paste-ready Claude Project instructions
  copilot/instructions.md   ← paste-ready Copilot Studio / M365 Copilot instructions (work only)
  memory/profile-template.md← template for Android's private memory
  scripts/build.sh          ← packages the skill zip + project bundle into dist/
  private/                  ← (git-ignored) your filled memory + generated briefs
```

> ⚠️ **This repository is public.** Personal details and Teck/CMZ data live only in
> `private/` (git-ignored), your Google Drive, and your Claude Project, never in git.

---

## Setup: pick a route (A takes ~10 minutes)

### A. Claude Project on claude.ai (works today, phone + desktop) ⭐ recommended
1. claude.ai → **Projects → Create project** → name it **Android**.
2. **Project instructions:** paste the block from [`project/system-prompt.md`](project/system-prompt.md).
3. **Project knowledge:** upload every file in `skill/android/references/` **and** your
   private memory (`private/memoria-android.md`, also saved in your Drive folder
   "Android (asistente personal)").
4. **Settings → Connectors:** enable **Gmail, Google Calendar, Google Drive**.
5. Open a chat in the project and say: **"Buenos días, Android."**

### B. Claude Skill (claude.ai Skills or Claude Code)
1. Run `bash android/scripts/build.sh` → creates `android/dist/android-skill.zip`.
2. claude.ai → **Settings → Capabilities → Skills → Upload skill** → choose the zip.
   (Claude Code: copy `skill/android/` to `~/.claude/skills/android/`.)
3. Any chat: "Android, ¿qué tengo hoy?"

### C. Inside Teck (Copilot Studio / M365 Copilot agent): work features only
1. Copilot Studio → **Create agent** → name **Android**.
2. Paste the block from [`copilot/instructions.md`](copilot/instructions.md) into *Instructions*.
3. *Knowledge*: the SharePoint/OneDrive folder with the tracker & weekly report, LOR
   templates, and the `references/` playbooks.
4. Publish to Teams (you only, or your team).

### Optional: automatic morning brief
In a Claude Code cloud session, ask: *"Programa el brief de Android todos los días
laborables a las 7:10 (Lima)."* It reads Gmail/Calendar/Drive and leaves the brief
ready when you wake up.

---

## Updating Android
- Personality or behaviour → edit `skill/android/references/*.md`, rebuild, re-upload.
- Facts about your life/work → update the **private** memory only.
- Keep the Copilot block ≤ 8,000 characters (`scripts/build.sh` checks it).
