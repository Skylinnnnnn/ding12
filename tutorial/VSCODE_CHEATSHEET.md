# VS Code Cheatsheet (keep this open)

A one-page reference for the editor you'll live in. You don't need to memorize
these — glance here until they become muscle memory. Shortcuts are shown as
**Windows** / **macOS**.

---

## First: which terminal do I use, and when?

| When | Where to run commands |
| --- | --- |
| **Chapter 01 only** (create GitHub account, install Git, `git init` the folder) | A **standalone terminal** — **PowerShell** on Windows (Start menu → "PowerShell"), **Terminal** on macOS. Your project folder and VS Code aren't set up yet. |
| **Chapter 03 onward** (everything else — dbt, git, python, npm) | **VS Code's built-in terminal.** Open the `ding12` folder in VS Code, then **View → Terminal** (`` Ctrl+` ``). |

> **On Windows, the VS Code terminal *is* a PowerShell window.** So "run it in
> PowerShell" and "run it in the VS Code terminal" are the same thing once you're
> in VS Code — you don't open PowerShell separately anymore. Every command in the
> tutorials runs in that one built-in terminal, with your `(.venv)` active.

**Rule of thumb:** after chapter 01, you never need to leave VS Code. Editor on
one side, terminal on the other, both in the same window.

---

## The 6 you'll use constantly
| Action | Windows | macOS |
| --- | --- | --- |
| **Command Palette** (do anything by name) | `Ctrl+Shift+P` | `Cmd+Shift+P` |
| **Toggle the terminal** | `` Ctrl+` `` | `` Ctrl+` `` |
| **Quick-open a file by name** | `Ctrl+P` | `Cmd+P` |
| **Save** | `Ctrl+S` | `Cmd+S` |
| **Find in this file** | `Ctrl+F` | `Cmd+F` |
| **Search across all files** | `Ctrl+Shift+F` | `Cmd+Shift+F` |

## Opening things
| Action | Windows | macOS |
| --- | --- | --- |
| Open a folder (start a project) | `Ctrl+K Ctrl+O` | `Cmd+K Cmd+O` |
| New terminal | `` Ctrl+Shift+` `` | `` Ctrl+Shift+` `` |
| Split the terminal (two side by side) | `Ctrl+Shift+5` | `Cmd+\` (in terminal) |
| Toggle the file sidebar | `Ctrl+B` | `Cmd+B` |
| Preview a Markdown file (`.md`) | `Ctrl+Shift+V` | `Cmd+Shift+V` |

## Editing SQL / YAML / Markdown faster
| Action | Windows | macOS |
| --- | --- | --- |
| Comment / uncomment line(s) | `Ctrl+/` | `Cmd+/` |
| Move line up / down | `Alt+↑ / Alt+↓` | `Option+↑ / Option+↓` |
| Copy line up / down | `Shift+Alt+↑ / ↓` | `Shift+Option+↑ / ↓` |
| Select next matching word (multi-edit) | `Ctrl+D` (repeat) | `Cmd+D` (repeat) |
| Add cursors by clicking | `Alt+Click` | `Option+Click` |
| Go to a line number | `Ctrl+G` | `Ctrl+G` |
| Format the document | `Shift+Alt+F` | `Shift+Option+F` |

## Project-specific things via the Command Palette
Press `Ctrl/Cmd+Shift+P`, then type:
- **`Python: Select Interpreter`** → pick the `.venv` entry, so new terminals
  auto-activate your virtual environment (see chapter 03).
- **`Terminal: Kill All Terminals`** → stop a stuck server (docs 8080, DuckDB UI
  4213, Evidence 3000). Or just click the terminal and press `Ctrl+C`.
- **`Git: Commit`**, **`Git: Push`** → the GUI way, if you prefer buttons to typing
  (the Source Control icon in the left sidebar does the same).

---

## Bonus: the everyday project commands (run in the VS Code terminal)
Not VS Code shortcuts, but the handful you'll type most. All run with `(.venv)`
active, from the `ding12` folder.

| Goal | Command |
| --- | --- |
| Build + test the whole warehouse | `dbt build` |
| Build just one layer | `dbt run --select staging` (or `intermediate` / `marts`) |
| Open the docs + lineage site | `dbt docs generate && dbt docs serve` |
| Explore the data (DuckDB UI) | `python scripts/open_ui.py` |
| Run the dashboard locally | `cd reports && npm run dev` |
| Save your work to GitHub | `git add -A && git commit -m "..." && git push` |
| Stop a running server | `Ctrl+C` |

> One DuckDB rule to remember: **only one program can open `ding12.duckdb` at a
> time.** Stop the DuckDB UI or Evidence (`Ctrl+C`) before running `dbt build`.
