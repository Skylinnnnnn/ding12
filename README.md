# Ding12 — Commerce Marketplace Analytics with dbt

> *Ding12 is a nickname for this project. A fuller descriptive name is
> "bitemetrics — commerce marketplace analytics."*

Ding12 transforms raw Olist marketplace data into **tested, documented,
dashboard-ready marts** for marketplace growth, seller performance, delivery
reliability, customer experience, category performance, and payment behavior —
and serves them through a **live interactive dashboard**.

### 📊 Live dashboard: https://skylinnnnnn.github.io/ding12/
Built with [Evidence](https://evidence.dev) on the dbt marts and auto-deployed
from `main` via GitHub Actions.

**The current MVP is local-first using dbt Core and DuckDB.** A future polish
version will migrate the same project to **dbt Cloud with BigQuery** to
demonstrate a more production-like analytics workflow. That cloud phase is
additive — it does **not** replace the local MVP and should not block it.

---

## Dataset
**Brazilian E-Commerce Public Dataset by Olist** — Kaggle slug
`olistbr/brazilian-ecommerce` (~100k orders, thousands of sellers, ~70 product
categories).

**Direct link:** https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?resource=download

### Manual Kaggle download (no API for the MVP)
1. Open the dataset page: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?resource=download
   (sign in to Kaggle first — a free account is required to download).
2. Click **Download** (downloads `archive.zip`).
3. Unzip the downloaded file.
4. Copy all CSV files into the **`seeds/`** folder.
5. Confirm the CSVs are **directly under `seeds/`**, not inside a nested folder.
6. Run `dbt seed`.

Confirm the files are present:
```bash
ls seeds/*.csv
```

Modeled seed files (geolocation is intentionally excluded from the MVP):
`olist_customers_dataset.csv`, `olist_orders_dataset.csv`,
`olist_order_items_dataset.csv`, `olist_order_payments_dataset.csv`,
`olist_order_reviews_dataset.csv`, `olist_products_dataset.csv`,
`olist_sellers_dataset.csv`, `product_category_name_translation.csv`.

---

## Business questions
- Is the marketplace growing (orders, GMV, active customers)?
- What are the completion and cancellation trends?
- Which sellers drive value, and which are high-value but high-risk?
- How reliable is delivery, and is it improving?
- How do customer reviews trend, and do late deliveries hurt them?
- Which categories and payment types drive the business?

## Tech stack
| Layer | Tool |
| --- | --- |
| Source of truth | GitHub repo |
| Editor | VS Code |
| Execution | terminal |
| Warehouse (MVP) | DuckDB |
| Transformations | dbt Core + dbt-duckdb |
| Docs & lineage | dbt docs |
| Data exploration | DuckDB browser UI |
| Dashboards | Evidence (SQL + markdown BI) |
| Deployment | GitHub Actions → GitHub Pages |
| Future polish | dbt Cloud + BigQuery |

## Repo structure
```
Ding12/
├── README.md
├── requirements.txt
├── .gitignore
├── dbt_project.yml
├── profiles.example.yml
├── seeds/                # Olist CSVs (manual download) + schema.yml
├── models/
│   ├── staging/          # stg_*  (views: clean/cast/standardize)
│   ├── intermediate/     # int_*  (views: joins + business logic)
│   └── marts/            # mart_* (tables: dashboard-ready)
├── macros/               # safe_divide
├── tests/                # singular data-quality tests
├── scripts/              # open_ui.py (DuckDB browser UI launcher)
├── analyses/             # ad-hoc, non-materialized SQL
├── dashboards/           # business-facing dashboard specs (blueprints)
├── reports/              # live Evidence dashboard (reads the DuckDB marts)
├── docs/                 # glossary, assumptions, interview story, resume, cloud plan
├── tutorial/             # step-by-step guide (00–09)
└── .github/workflows/    # deploy.yml — build + publish dashboard to Pages
```

## dbt model architecture
**seeds → staging → intermediate → marts**, each layer with one job:
- **staging** (`stg_*`, views): one model per source; clean, cast, rename. No logic.
- **intermediate** (`int_*`, views): reusable joins and business logic (delivery
  timing, order enrichment, review experience, category/seller facts).
- **marts** (`mart_*`, tables): aggregated, dashboard-ready outputs.

Six marts: `mart_daily_marketplace_metrics`, `mart_seller_performance`,
`mart_delivery_reliability`, `mart_customer_experience`,
`mart_category_performance`, `mart_payment_behavior`.

## Key metrics
GMV (order-item `price + freight`), AOV, gross/completed/canceled orders,
completion & cancellation rates, late delivery rate, delivery delay days,
average review score, low review rate, active customers. Full definitions in
[`docs/metrics_glossary.md`](docs/metrics_glossary.md); assumptions in
[`docs/business_assumptions.md`](docs/business_assumptions.md).

---

## Setup & run (local MVP)
> **Python version:** dbt needs **Python 3.9–3.13** (not 3.14). Check with
> `python3 --version` (Windows: `python --version`). If you're on 3.14: Windows →
> `winget install Python.Python.3.12`; macOS → `brew install python@3.12`. Full
> **Windows + macOS/Linux** step-by-step (including venv activation and the DuckDB
> UI) is in [`tutorial/01_environment_setup.md`](tutorial/01_environment_setup.md).

macOS / Linux:
```bash
# 1. Environment
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

# 2. dbt profile -> DuckDB
mkdir -p ~/.dbt
cp profiles.example.yml ~/.dbt/profiles.yml
dbt debug

# 3. Data: download Kaggle CSVs manually, unzip, copy into seeds/, then:
ls seeds/*.csv

# 4. Build & test
dbt seed
dbt build           # seed + run + test in dependency order

# 5. Docs & lineage UI, and the DuckDB data UI
dbt docs generate
dbt docs serve            # lineage/docs at http://localhost:8080 ; Ctrl+C to stop
python scripts/open_ui.py # browse the actual data at http://localhost:4213
```

Windows (PowerShell) — same steps, different shell:
```powershell
# 1. Environment
py -3.12 -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt

# 2. dbt profile -> DuckDB
mkdir $HOME\.dbt -Force
copy profiles.example.yml $HOME\.dbt\profiles.yml
dbt debug

# 3. Data: download Kaggle CSVs manually, unzip, copy into seeds\, then:
dir seeds\*.csv

# 4. Build & test
dbt seed
dbt build

# 5. Docs UI + DuckDB data UI
dbt docs generate
dbt docs serve
python scripts\open_ui.py
```

### Explore the data visually (DuckDB UI)
`python scripts/open_ui.py` opens DuckDB's built-in browser UI at
http://localhost:4213 to browse every seed/view/mart and run SQL — works the same
on Windows and macOS. See [`tutorial/08_explore_data_duckdb_ui.md`](tutorial/08_explore_data_duckdb_ui.md)
for that plus DuckDB-CLI and DBeaver alternatives. **Only one process can open
`ding12.duckdb` at a time** — stop the UI (Ctrl+C) before running `dbt build`.

## Dashboards
Two layers:
- **Specs** (blueprints) in [`dashboards/`](dashboards/): audience, questions,
  metrics, charts, filters, example insights.
- **Live interactive dashboard** in [`reports/`](reports/), built with
  [Evidence](https://evidence.dev) directly on the DuckDB marts — Executive
  Overview, Seller Performance, Delivery Reliability, Customer Experience, and
  Category Performance.

**Live URL:** https://skylinnnnnn.github.io/ding12/ — auto-published on every push
to `main` by [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml), which
rebuilds the warehouse with dbt (from the committed seeds) and redeploys.

Run it locally (after `dbt build`, with Node 18+ installed):
```bash
cd reports
npm install        # one time
npm run sources    # materialize the marts to parquet
npm run dev        # open http://localhost:3000
```
Full walkthrough (Windows + macOS): [`tutorial/09_dashboards_evidence.md`](tutorial/09_dashboards_evidence.md).

## Resume bullets & interview story
See [`docs/resume_bullets.md`](docs/resume_bullets.md) and
[`docs/interview_story.md`](docs/interview_story.md).

> **Interview talking point:** "I first built the project locally with dbt Core
> and DuckDB to keep it lightweight and reproducible. Then I planned a dbt Cloud
> + BigQuery polish phase to mirror a more production-like analytics workflow,
> including GitHub integration, cloud-warehouse execution, docs, lineage, and
> scheduled jobs."

## Future polish: dbt Cloud + BigQuery version
A future version migrates this project to dbt Cloud + BigQuery to demonstrate a
more production-like workflow (browser IDE, managed environments, scheduled jobs,
hosted docs/lineage). This is a polish phase, **not** required for the MVP and
**not** a replacement for it. Step-by-step plan:
[`docs/cloud_migration_plan.md`](docs/cloud_migration_plan.md) and
[`tutorial/07_dbt_cloud_bigquery.md`](tutorial/07_dbt_cloud_bigquery.md).

## Next steps
1. Download the Kaggle CSVs into `seeds/` and run `dbt build`.
2. Explore the data in the DuckDB UI (`python scripts/open_ui.py`) and lineage
   with `dbt docs serve`.
3. Run the live dashboard locally (`cd reports && npm run sources && npm run dev`),
   or browse the deployed one at https://skylinnnnnn.github.io/ding12/.
4. When ready, follow the cloud migration plan for the dbt Cloud + BigQuery
   version.
