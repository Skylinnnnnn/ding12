# Ding12 Build Checklist

The tick-through version of the tutorials. Build into **your own** repo; use the
[reference repo](https://github.com/Skylinnnnnn/ding12) as an answer key.

**Legend — *what*:** ✍️ = write it yourself · 📋 = copy it (and read it).
**Legend — *where*:** 💻 = on your computer (VS Code editor/terminal, or viewing
`localhost`) · 🌐 = in a web browser on a real website (github.com, Kaggle, your
live URL). *Almost everything is 💻 — the 🌐 steps are the rare exceptions, so
watch for them.*

New to VS Code? Keep [`VSCODE_CHEATSHEET.md`](VSCODE_CHEATSHEET.md) open — shortcuts
plus which terminal to use when.

## 0. Setup — [`01`](01_github_and_git_setup.md), [`02`](02_how_it_all_fits.md) & [`03`](03_environment_setup.md)
- [ ] 💻 Read [`02`](02_how_it_all_fits.md) — the map (where tools live + the whole process)
- [ ] 🌐 Create a GitHub account (github.com)
- [ ] 💻 Install Git + GitHub CLI (`git --version`, `gh --version`)
- [ ] 💻 `git config --global` your name + private no-reply email
- [ ] 💻 `gh auth login` (GitHub.com → HTTPS → browser) — you run it in the terminal; it opens a browser only to approve
- [ ] 💻 `mkdir ding12 && cd ding12 && git init`, then `gh repo create ding12 --public --source=. --remote=origin`
- [ ] 💻 First commit + push; create the folder skeleton
- [ ] 💻 📋 Copy config files: `requirements.txt`, `.gitignore`, `dbt_project.yml`, `profiles.example.yml`
- [ ] 💻 Check Python is 3.9–3.13; create venv; `pip install -r requirements.txt`
- [ ] 💻 Confirm the venv is active — prompt shows `(.venv)` and `dbt --version` runs
- [ ] 💻 `cp profiles.example.yml ~/.dbt/profiles.yml` → `dbt debug` (all green)

## 1. Data — [`03`](03_environment_setup.md)
- [ ] 🌐 Download the [Kaggle Olist dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?resource=download) manually (kaggle.com)
- [ ] 💻 Copy the CSVs directly into `seeds/`; confirm with `ls seeds/*.csv`
- [ ] 💻 ✍️ Write `seeds/schema.yml` (light descriptions) → `dbt seed`

## 2. Staging — [`05`](05_building_staging_models.md)  ✍️
- [ ] 💻 Write the 8 `stg_*.sql` models (`ref()` the seeds; cast; standardize strings)
- [ ] 💻 Write `models/staging/schema.yml` tests: `unique`/`not_null` on true keys,
      `accepted_values`, `relationships` — [dbt tests docs](https://docs.getdbt.com/docs/build/data-tests)
- [ ] 💻 `dbt run --select staging && dbt test --select staging` → commit + push

## 3. Intermediate — [`06`](06_building_intermediate_models.md)  ✍️
- [ ] 💻 Decide each model's **grain first**, then write the 5 `int_*.sql`
- [ ] 💻 Write `models/intermediate/schema.yml` (grain + key-field notes)
- [ ] 💻 `dbt build --select intermediate` → commit + push

## 4. Marts — [`07`](07_building_marts.md)  ✍️
- [ ] 💻 📋 Copy `macros/safe_divide.sql`; ✍️ write the 6 `mart_*.sql`
- [ ] 💻 ✍️ Write the 2 singular tests in `tests/`
- [ ] 💻 Write `models/marts/schema.yml` (grain + purpose + tests)
- [ ] 💻 `dbt build` (full) → all green → commit + push

## 5. Explore & document — [`08`](08_dbt_docs_local_ui.md) & [`09`](09_explore_data_duckdb_ui.md)
- [ ] 💻 `dbt docs generate && dbt docs serve` — read your lineage graph (`localhost:8080`)
- [ ] 💻 📋 Copy `scripts/open_ui.py`; run it and try the guided sample query (`localhost:4213`)

## 6. Dashboard — [`10`](10_dashboards_evidence.md)
- [ ] 💻 📋 Scaffold Evidence: `npx degit evidence-dev/template reports && cd reports && npm install`
- [ ] 💻 Wire the `ding12` source (📋 `connection.yaml`, ✍️ one `.sql` per mart)
- [ ] 💻 ✍️ Write the pages in `reports/pages/` — [Evidence components](https://docs.evidence.dev/components/all-components/)
- [ ] 💻 `npm run sources && npm run dev` → view at `localhost:3000`

## 7. Deploy — [`10`](10_dashboards_evidence.md)
- [ ] 💻 📋 Copy `.github/workflows/deploy.yml`; **adjust base path + URL** to your repo
- [ ] 💻 Ensure the deploy runs `npm run sources` before `npm run build` (essential!)
- [ ] 💻 Push to `main` (this triggers the deploy)
- [ ] 🌐 On github.com: **Settings → Pages → Source = GitHub Actions**
- [ ] 🌐 Confirm your live URL: `https://<your-username>.github.io/<your-repo>/`

## 8. Portfolio docs — [`11`](11_portfolio_docs.md)  ✍️
- [ ] 💻 ✍️ `docs/metrics_glossary.md` — define every metric straight from your SQL
- [ ] 💻 ✍️ `docs/business_assumptions.md` — the judgment calls + what the tests taught you
- [ ] 💻 ✍️ `docs/interview_story.md` — 60-sec pitch, 3-min deep dive, why dbt/DuckDB/Evidence
- [ ] 💻 ✍️ `docs/resume_bullets.md` — bullets grouped by target role
- [ ] 💻 Fill in `README.md` → commit + push
- [ ] 💻 Read [`12`](12_dbt_cloud_bigquery.md) for the dbt Cloud + BigQuery future path
