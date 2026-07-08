# Ding12 Build Checklist

The tick-through version of the tutorials. Build into **your own** repo; use the
[reference repo](https://github.com/Skylinnnnnn/ding12) as an answer key. Legend:
✍️ = write it yourself · 📋 = copy it (and read it).

## 0. Setup — [`00b`](00b_github_and_git_setup.md) & [`01`](01_environment_setup.md)
- [ ] Create a GitHub account; install Git + GitHub CLI (`git --version`, `gh --version`)
- [ ] `git config --global` your name + private no-reply email
- [ ] `gh auth login` (GitHub.com → HTTPS → browser)
- [ ] `mkdir ding12 && cd ding12 && git init`, then `gh repo create ding12 --public --source=. --remote=origin`
- [ ] First commit + push; create the folder skeleton
- [ ] 📋 Copy config files: `requirements.txt`, `.gitignore`, `dbt_project.yml`, `profiles.example.yml`
- [ ] Check Python is 3.9–3.13; create venv; `pip install -r requirements.txt`
- [ ] `cp profiles.example.yml ~/.dbt/profiles.yml` → `dbt debug` (all green)

## 1. Data — [`01`](01_environment_setup.md)
- [ ] Download the [Kaggle Olist dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?resource=download) manually
- [ ] Copy the CSVs directly into `seeds/`; confirm with `ls seeds/*.csv`
- [ ] ✍️ Write `seeds/schema.yml` (light descriptions) → `dbt seed`

## 2. Staging — [`03`](03_building_staging_models.md)  ✍️
- [ ] Write the 8 `stg_*.sql` models (`ref()` the seeds; cast; standardize strings)
- [ ] Write `models/staging/schema.yml` tests: `unique`/`not_null` on true keys,
      `accepted_values`, `relationships` — [dbt tests docs](https://docs.getdbt.com/docs/build/data-tests)
- [ ] `dbt run --select staging && dbt test --select staging` → commit + push

## 3. Intermediate — [`04`](04_building_intermediate_models.md)  ✍️
- [ ] Decide each model's **grain first**, then write the 5 `int_*.sql`
- [ ] Write `models/intermediate/schema.yml` (grain + key-field notes)
- [ ] `dbt build --select intermediate` → commit + push

## 4. Marts — [`05`](05_building_marts.md)  ✍️
- [ ] 📋 Copy `macros/safe_divide.sql`; ✍️ write the 6 `mart_*.sql`
- [ ] ✍️ Write the 2 singular tests in `tests/`
- [ ] Write `models/marts/schema.yml` (grain + purpose + tests)
- [ ] `dbt build` (full) → all green → commit + push

## 5. Explore & document — [`06`](06_dbt_docs_local_ui.md) & [`08`](08_explore_data_duckdb_ui.md)
- [ ] `dbt docs generate && dbt docs serve` — read your lineage graph
- [ ] 📋 Copy `scripts/open_ui.py`; run it and try the guided sample query

## 6. Dashboard — [`09`](09_dashboards_evidence.md)
- [ ] 📋 Scaffold Evidence: `npx degit evidence-dev/template reports && cd reports && npm install`
- [ ] Wire the `ding12` source (📋 `connection.yaml`, ✍️ one `.sql` per mart)
- [ ] ✍️ Write the pages in `reports/pages/` — [Evidence components](https://docs.evidence.dev/components/all-components/)
- [ ] `npm run sources && npm run dev` → view at http://localhost:3000

## 7. Deploy — [`09`](09_dashboards_evidence.md)
- [ ] 📋 Copy `.github/workflows/deploy.yml`; **adjust base path + URL** to your repo
- [ ] Ensure the deploy runs `npm run sources` before `npm run build` (essential!)
- [ ] Push to `main`; GitHub → Settings → Pages → Source = **GitHub Actions**
- [ ] Confirm your live URL: `https://<your-username>.github.io/<your-repo>/`

## 8. Portfolio polish
- [ ] Fill in `README.md` and the `docs/` (glossary, assumptions, interview story, resume)
- [ ] Read [`07`](07_dbt_cloud_bigquery.md) for the dbt Cloud + BigQuery future path
