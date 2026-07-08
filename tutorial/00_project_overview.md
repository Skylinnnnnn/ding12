# 00 — Project Overview

Welcome. This tutorial series walks you through Ding12 as a working example of a
modern analytics-engineering project. You already know SQL and business
analytics deeply — the goal here is to connect that expertise to the tooling
(Git, terminal, dbt, DuckDB, docs) that modern data teams use.

## How to use these tutorials
**Build your own copy from scratch.** Create your own GitHub account and your own
`ding12` repo (chapter `00b`), then build each piece into it as you read. Don't
clone the reference repo and run it — the learning is in the doing.

Use the **reference repo as an answer key** to check your work when you're stuck:
https://github.com/Skylinnnnnn/ding12

Each build chapter marks files two ways:
- ✍️ **Write this yourself** — where the real learning is (SQL models, dbt tests).
  Type it, referencing the linked docs.
- 📋 **Copy this** — plumbing/config where typing teaches nothing (project config,
  `.gitignore`, CI workflow). Copy it, but read it so you understand what it does.

The pattern within a layer is *worked example → you try*: build one model + its
tests fully, then repeat the pattern for the rest.

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
Follow the end-to-end **[build checklist](CHECKLIST.md)** as you go — it's the
tick-through version of the chapters below.

1. `00b_github_and_git_setup.md` — create your account, repo, and first commit.
2. `01_environment_setup.md` — install, get the data, first run.
3. `02_dbt_mental_model.md` — how dbt thinks.
4. `03_building_staging_models.md`  ✍️
5. `04_building_intermediate_models.md`  ✍️
6. `05_building_marts.md`  ✍️
7. `06_dbt_docs_local_ui.md` — lineage and docs UI.
8. `08_explore_data_duckdb_ui.md` — see the data visually + a guided sample query.
9. `09_dashboards_evidence.md` — build the live dashboard and deploy it.
10. `07_dbt_cloud_bigquery.md` — the future production-like path (read anytime).

## Official docs — keep these open
Bookmark these; the ✍️ chapters expect you to reference them while you write.

**dbt (official docs, docs.getdbt.com):**
- [Install dbt Core](https://docs.getdbt.com/docs/core/installation-overview) ·
  [dbt-duckdb adapter setup](https://docs.getdbt.com/docs/core/connect-data-platform/duckdb-setup)
- [How we structure dbt projects](https://docs.getdbt.com/best-practices/how-we-structure/1-guide-overview)
  (the staging → intermediate → marts pattern)
- [Models](https://docs.getdbt.com/docs/build/models) ·
  [Materializations](https://docs.getdbt.com/docs/build/materializations) ·
  [`ref()`](https://docs.getdbt.com/reference/dbt-jinja-functions/ref) ·
  [Seeds](https://docs.getdbt.com/docs/build/seeds)
- [Data tests](https://docs.getdbt.com/docs/build/data-tests) ·
  [Test properties (unique/not_null/relationships/accepted_values)](https://docs.getdbt.com/reference/resource-properties/data-tests)
- [`dbt_project.yml` reference](https://docs.getdbt.com/reference/dbt_project.yml) ·
  [Connection profiles](https://docs.getdbt.com/docs/core/connect-data-platform/connection-profiles) ·
  [dbt commands](https://docs.getdbt.com/reference/dbt-commands)
- [Jinja & macros](https://docs.getdbt.com/docs/build/jinja-macros) ·
  [Documentation & `dbt docs`](https://docs.getdbt.com/docs/build/documentation)

**Other tools:**
- [DuckDB docs](https://duckdb.org/docs/) ·
  [DuckDB UI](https://duckdb.org/docs/stable/core_extensions/ui)
- [Evidence docs](https://docs.evidence.dev/) ·
  [Evidence components](https://docs.evidence.dev/components/all-components/)
- [GitHub Docs: Hello World / repos](https://docs.github.com/en/get-started/quickstart/hello-world) ·
  [GitHub Pages](https://docs.github.com/en/pages)
