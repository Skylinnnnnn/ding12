# Ding12 — Commerce Marketplace Analytics with dbt

> *Ding12 is a nickname for this project. A fuller descriptive name is
> "bitemetrics — commerce marketplace analytics."*

Ding12 transforms raw Olist marketplace data into **tested, documented,
dashboard-ready marts** for marketplace growth, seller performance, delivery
reliability, customer experience, category performance, and payment behavior.

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
├── analyses/             # ad-hoc, non-materialized SQL
├── dashboards/           # business-facing dashboard specs
├── docs/                 # glossary, assumptions, interview story, resume, cloud plan
└── tutorial/             # step-by-step guide (00–07)
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
> `python3 --version`. On macOS, if you're on 3.14, run `brew install python@3.12`
> and create the venv with `/opt/homebrew/opt/python@3.12/bin/python3.12` instead
> of `python3`. Details in [`tutorial/01_environment_setup.md`](tutorial/01_environment_setup.md).

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
# (or granular: dbt run && dbt test)

# 5. Docs & lineage UI
dbt docs generate
dbt docs serve      # opens http://localhost:8080 ; Ctrl+C to stop
```

## Dashboard plan
Specs (audience, questions, metrics, charts, filters, example insights) live in
[`dashboards/`](dashboards/): Executive Overview, Seller Performance, Delivery
Reliability, Customer Experience.

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
2. Explore lineage with `dbt docs serve`.
3. Point a BI tool (or `dashboards/` specs) at the marts.
4. When ready, follow the cloud migration plan for the dbt Cloud + BigQuery
   version.
