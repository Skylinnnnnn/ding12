# 07 — dbt Cloud + BigQuery (Future Path)

> **Do not implement this phase yet.** The local MVP is complete and interview-
> ready on its own. This chapter explains where the project *can* go next.

## Why we started locally first
Local dbt Core + DuckDB gives you a fully reproducible project with zero cloud
setup, zero cost, and instant iteration. Anyone can clone the repo, add the CSVs,
and get an identical warehouse. That's the ideal foundation for a portfolio —
and it proves the analytics logic works before any infrastructure is involved.

## What changes moving DuckDB → BigQuery
- The **warehouse** changes from a local file to a managed cloud warehouse.
- **Compute** moves from your laptop to Google Cloud.
- You load the CSVs into **BigQuery tables** and point a `bigquery` profile
  target at your project/dataset with credentials (service account or OAuth).
- Some **SQL dialect** details may need small tweaks (function names, types), but
  the structure is unchanged.

## What dbt Cloud adds
- A **browser-based IDE** (no local setup for collaborators).
- **Managed environments** (dev/prod separation).
- **Jobs** — scheduled runs of `dbt build`, with logs and alerting.
- **Hosted docs and lineage** shareable via URL.
- Built-in **Git integration** and pull-request workflows.

## What stays exactly the same
Your **models, `ref()`s, tests, marts, metric definitions, and GitHub repo
structure**. That portability is the payoff: the same governed transformation
layer runs on a real cloud warehouse with scheduled jobs.

## Why this matters for tech-company analytics roles
This is the setup most modern data teams actually use. Being able to say "I built
it locally to prove the logic, then ran the identical dbt project on BigQuery via
dbt Cloud with scheduled jobs and hosted docs" tells hiring teams you understand
the full production workflow — not just the SQL.

See `docs/cloud_migration_plan.md` for the concrete step list.
