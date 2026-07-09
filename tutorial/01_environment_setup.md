# 01 — Environment Setup

> **This guide covers both Windows and macOS/Linux.** Commands are shown for each
> where they differ. Run everything from the repo root (the folder you `git init`ed
> in chapter `00b`).

## Create the project config files  📋 copy
These are configuration/boilerplate — **copy them** from the reference repo into
your repo root, then read each one so you know what it does (don't just paste
blindly). Look up anything unfamiliar in the [dbt project config docs](https://docs.getdbt.com/reference/dbt_project.yml).

| File | What it does | Reference |
| --- | --- | --- |
| `requirements.txt` | Python packages (dbt-core, dbt-duckdb, duckdb, pandas) | [reference](https://github.com/Skylinnnnnn/ding12/blob/main/requirements.txt) |
| `.gitignore` | Keeps venv, DuckDB files, secrets, and artifacts out of Git | [reference](https://github.com/Skylinnnnnn/ding12/blob/main/.gitignore) |
| `dbt_project.yml` | Names the project, sets paths, and the view/table strategy | [reference](https://github.com/Skylinnnnnn/ding12/blob/main/dbt_project.yml) |
| `profiles.example.yml` | The DuckDB connection template | [reference](https://github.com/Skylinnnnnn/ding12/blob/main/profiles.example.yml) |

Commit them: `git add -A && git commit -m "Add project config" && git push`.

## 0. Check your Python version first (important)
dbt supports **Python 3.9–3.13**. It does **not** yet run on Python **3.14**, and
`pip install` will fail if that's your default. Check:

```bash
# Windows
python --version

# macOS / Linux
python3 --version
```

If it says 3.9–3.13, you're good. If it says **3.14** (or Python isn't installed):

- **Windows:** install 3.12 from the Microsoft Store or python.org, or run
  `winget install Python.Python.3.12`. Then use `py -3.12` in place of `python`
  when creating the venv in step 1.
- **macOS (Homebrew):** `brew install python@3.12`, then use the full path
  `/opt/homebrew/opt/python@3.12/bin/python3.12` in place of `python3` in step 1.

(You only need the specific version to *create* the venv — once it exists, the
`python`/`pip` inside it are already the right version.)

## 1. Python virtual environment
A virtual environment keeps this project's packages isolated from the rest of
your machine.

```bash
# Windows (PowerShell)
py -3.12 -m venv .venv               # or: python -m venv .venv
.venv\Scripts\Activate.ps1           # activate (Command Prompt: .venv\Scripts\activate.bat)
python -m pip install --upgrade pip
pip install -r requirements.txt

# macOS / Linux
python3 -m venv .venv                # or the python@3.12 path from step 0
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

> **Windows PowerShell note:** if `Activate.ps1` is blocked by an execution
> policy, run once: `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`, then
> activate again.

You'll know it worked when your prompt shows `(.venv)` and `dbt --version` runs.

### Understanding the `(.venv)` prefix — and how to leave it
Once the venv exists, you'll notice **every new VS Code terminal opens with
`(.venv)` already showing** at the start of the prompt. That's expected and
good — here's what's going on:

- **What `(.venv)` means:** your commands now use *this project's* isolated
  Python and packages (dbt lives here), not your system-wide Python. You want it
  active whenever you run `dbt`.
- **Why it turns on by itself:** VS Code's Python extension remembers the
  interpreter for this folder and **auto-activates the venv** in each new
  terminal. You didn't do anything wrong — it's a convenience.
- **Make it reliable:** if a terminal ever opens *without* `(.venv)`, select the
  interpreter once via Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`) →
  **Python: Select Interpreter** → pick the entry that points at `.venv`. New
  terminals will then auto-activate it.
- **How to leave it:** just type `deactivate` (same on Windows + macOS) — the
  `(.venv)` disappears and you're back to system Python. You rarely need to;
  staying in the venv for this project is completely fine.
- **How to get back in:** re-run the activate command from step 1
  (`.venv\Scripts\Activate.ps1` on Windows, `source .venv/bin/activate` on
  macOS/Linux), or just open a fresh VS Code terminal.

Quick check any time: if the prompt shows `(.venv)` and `dbt --version` runs,
you're in the right place. (For the bigger picture of where the venv sits among
all the tools, see [`00c_how_it_all_fits.md`](00c_how_it_all_fits.md).)

## 2. Point dbt at DuckDB (the profile)
dbt reads connection settings from a `profiles.yml` in your user dbt folder.

```bash
# Windows (PowerShell)
mkdir $HOME\.dbt -Force
copy profiles.example.yml $HOME\.dbt\profiles.yml

# macOS / Linux
mkdir -p ~/.dbt
cp profiles.example.yml ~/.dbt/profiles.yml
```

This tells dbt to use DuckDB and to create a local database file
`ding12.duckdb` in the repo. Verify the connection:

```bash
dbt debug
```

All green checks = you're connected.

## 3. Get the data (manual Kaggle download)
We download the dataset **manually** (no Kaggle API for the MVP):

1. Open the dataset page (sign in to Kaggle first — a free account is required):
   https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?resource=download
2. Click **Download** (downloads `archive.zip`).
3. Unzip the downloaded file.
4. Copy **all CSV files** into the `seeds/` folder.
5. Confirm the CSVs sit **directly under `seeds/`**, not inside a nested folder.
6. Then run `dbt seed`.

Confirm the files are in place:

```bash
# Windows
dir seeds\*.csv

# macOS / Linux
ls seeds/*.csv
```

You should see the eight modeled files (customers, orders, order_items,
order_payments, order_reviews, products, sellers, product_category translation).
`olist_geolocation_dataset.csv` may also be present; it's fine to leave it — the
MVP doesn't model it.

## 4. Build everything
```bash
dbt seed      # load CSVs into DuckDB
dbt run       # build staging, intermediate, marts
dbt test      # run data-quality tests
dbt build     # (alternative) seed + run + test in dependency order
```

If `dbt seed` can't find the CSVs, revisit step 3 — the files must be directly
under `seeds/`.

## 5. See the data in a UI
To explore the tables visually in your browser, see
[`08_explore_data_duckdb_ui.md`](08_explore_data_duckdb_ui.md):

```bash
python scripts/open_ui.py     # opens http://localhost:4213
```
