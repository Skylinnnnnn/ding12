# 00c — How It All Fits (your map)

New tools can feel like a pile of disconnected names — Python, venv, dbt, DuckDB,
Git, GitHub, Evidence. This chapter is the **map**. Come back to it any time you
feel lost: the two diagrams below answer *"what connects to what"* and *"what do
I do next, and where am I right now."*

You already know the hard part (SQL and analytics). Everything here is just the
*wrapper* around your SQL — so read it once for orientation, don't memorize it.

---

## Diagram A — Where things live

Almost everything runs on **your own computer**. GitHub is a copy in the cloud.

```
┌───────────────────── YOUR COMPUTER (local) ─────────────────────┐
│                                                                 │
│  VS CODE  (one window, two halves)                              │
│    • Editor pane      → where you WRITE files (.sql .yml .md)    │
│    • Terminal (.venv) → where you RUN commands (dbt, git, npm)   │
│                                                                 │
│  In the terminal:                                               │
│    python → dbt ─────────────▶  ding12.duckdb   (local db file) │
│                     seeds ▸ staging ▸ intermediate ▸ marts       │
│                                        │                        │
│                                        ▼                        │
│                            Evidence (npm) ─▶ dashboard :3000     │
│                                                                 │
│  Your whole project folder sits on THIS computer.               │
└────────────────────────────────┬────────────────────────────────┘
                                  │
                 git push  ▲      │      ▼  git pull / clone
                                  │
┌───────────────────── GITHUB (the cloud) ────────────────────────┐
│  Your repo = code backup + public showcase                      │
│    └ GitHub Actions ─▶ rebuilds ─▶ GitHub Pages ─▶ LIVE URL      │
└─────────────────────────────────────────────────────────────────┘
```

**Read it like this:** you edit and run everything locally. When you're happy,
`git push` sends a copy up to GitHub. GitHub then automatically rebuilds the
dashboard and publishes it at your live URL. Nothing "runs" on GitHub that you
have to babysit — it just stores your code and auto-deploys the dashboard.

---

## Diagram B — The whole process, start to finish

This is the *order of things*. Each step is tagged with the **chapter** that
covers it, so you can always find where you are.

```
[00b]  create GitHub repo ───────────────▶ empty repo on GitHub
  │
[01]   install Python → make venv → pip install dbt ─▶ (.venv) ready
  │
[01]   download Kaggle CSVs into seeds/
  │
[01]   dbt seed ─────────────▶ CSVs loaded into ding12.duckdb
  │
[03]   write staging   stg_*   ─┐
[04]   write intermediate int_* ├─ dbt run ─▶ views + tables in DuckDB
[05]   write marts     mart_*   ─┘
  │
[03-05] write tests ─ dbt test ─▶ data quality enforced
  │
[06]   dbt docs generate + serve ─▶ lineage graph in browser
  │
[08]   python scripts/open_ui.py ─▶ explore the data (DuckDB UI)
  │
[09]   Evidence: npm run sources + dev ─▶ local dashboard :3000
  │
[09]   git push ─▶ GitHub Actions ─▶ Pages ─▶ LIVE dashboard URL
```

**Lost?** Find the chapter tag on the left that matches what you're doing —
that's where you are. Everything above it is done; everything below is still
ahead.

---

## Where do I write code — VS Code or GitHub?

This trips up almost everyone at first. The short answer:

> **You write code on your computer, in the VS Code editor. GitHub is where a
> copy goes to be backed up and shown off. You almost never type code on the
> github.com website.**

The github.com website is for *looking at* your project (and letting others look)
— reading files, seeing your commit history, watching the deploy run. The actual
writing happens in VS Code, and `git push` is the one action that carries your
work from your computer up to the website.

| What you want to do | Where you do it |
| --- | --- |
| Write or edit a `.sql` / `.yml` / `.md` file | **VS Code — editor pane** (on your computer) |
| Run `dbt`, `git`, `python`, `npm` | **VS Code — terminal** (on your computer) |
| Save your work to the cloud | `git push` (from the VS Code terminal) |
| View / share your project, see the deploy | **github.com** (the website, in a browser) |
| See the finished dashboard | your **live Pages URL** (in a browser) |

## What runs where

| Tool | Lives / runs on | What it is |
| --- | --- | --- |
| Python, venv, `pip` | your computer | the language + this project's isolated packages |
| dbt | your computer | runs your SQL models and tests |
| DuckDB (`ding12.duckdb`) | your computer | the local database file dbt builds into |
| Evidence / `npm` | your computer | builds the dashboard from the marts |
| Git | your computer | tracks changes and pushes them up |
| Your repo | GitHub (cloud) | the backup + public showcase of your code |
| GitHub Actions + Pages | GitHub (cloud) | auto-rebuilds and hosts the live dashboard |

## "Where am I right now?" — a 10-second self-check

When a terminal looks confusing, ask:

1. **Does my prompt show `(.venv)`?** If yes, my project's Python is active (good —
   `dbt`, and also `git` and `npm`, all work right here; you do *not* deactivate to
   run git). See [`01`](01_environment_setup.md) for what that means.
2. **Am I in the `ding12` folder?** Run `pwd` (macOS) / `cd` (Windows) to check.
   `dbt` and `npm` only work from inside the project folder.
3. **Is a server holding this terminal?** If you ran `dbt docs serve` (port 8080),
   `open_ui.py` (4213), or `npm run dev` (3000), that terminal is *busy* running
   it — press `Ctrl+C` to stop, or open a **second terminal** for other commands.

➡️ Next: [`01_environment_setup.md`](01_environment_setup.md) — install everything
and make that `(.venv)` appear.
