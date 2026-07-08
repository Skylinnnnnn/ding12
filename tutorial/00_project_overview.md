# 00 — Project Overview

Welcome. This tutorial series walks you through Ding12 as a working example of a
modern analytics-engineering project. You already know SQL and business
analytics deeply — the goal here is to connect that expertise to the tooling
(Git, terminal, dbt, DuckDB, docs) that modern data teams use.

## What Ding12 is
A commerce-marketplace analytics project that turns raw Olist e-commerce CSVs
into tested, documented, dashboard-ready marts covering:
- marketplace growth, seller performance, delivery reliability, customer
  experience, category performance, and payment behavior.

## The mental model in one line
**Raw seeds → staging (clean) → intermediate (business logic) → marts
(aggregated for dashboards)**, with tests and docs attached along the way.

## How the pieces fit
| Piece | Role |
| --- | --- |
| **GitHub repo** | Source of truth for all code and definitions. |
| **VS Code** | Editor. |
| **Terminal** | Where you run `dbt` and `npm` commands. |
| **DuckDB** | Local analytics database (a single file) + a browser UI to explore it. |
| **dbt Core** | SQL transformation + testing + docs framework. |
| **dashboards/** | Business-facing specs the marts are designed to feed. |
| **reports/** (Evidence) | The live interactive dashboard built on the marts. |
| **GitHub Actions** | Rebuilds and publishes the dashboard to GitHub Pages. |

## Reading order
1. `01_environment_setup.md` — install, get the data, first run.
2. `02_dbt_mental_model.md` — how dbt thinks.
3. `03_building_staging_models.md`
4. `04_building_intermediate_models.md`
5. `05_building_marts.md`
6. `06_dbt_docs_local_ui.md` — lineage and docs UI.
7. `07_dbt_cloud_bigquery.md` — the future production-like path.
8. `08_explore_data_duckdb_ui.md` — see the data visually + a guided sample query.
9. `09_dashboards_evidence.md` — the live Evidence dashboard and how it deploys.
