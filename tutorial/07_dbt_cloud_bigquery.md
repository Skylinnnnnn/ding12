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

## Important: Cloud changes the *environment*, not who writes the code
A common misconception is that dbt Cloud "auto-generates" your models or your
`schema.yml` tests. It does **not**. In *both* dbt Core (local) and dbt Cloud,
**you write the model SQL and the tests by hand** — that's the actual analytics
work, and it's identical either way. dbt Cloud only changes the *surroundings*:
a browser IDE instead of VS Code, managed environments instead of your laptop,
a scheduler, and hosted docs. Don't arrive at Cloud expecting it to do the
modeling for you.

Anything that *does* scaffold boilerplate — `dbt init` (project skeleton) or the
[`dbt-codegen`](https://github.com/dbt-labs/dbt-codegen) package (which can stub
out a `schema.yml` with your columns pre-listed) — runs perfectly in **local
Core too**. So building locally costs you nothing in convenience; it just makes
the ✍️ parts (the models and tests) explicit, which is where the learning is.
dbt Cloud does have an AI add-on ("dbt Copilot") that can *suggest* docs/tests,
but that's a paid feature and a suggestion, not automatic generation.

## Why this matters for tech-company analytics roles
This is the setup most modern data teams actually use. Being able to say "I built
it locally to prove the logic, then ran the identical dbt project on BigQuery via
dbt Cloud with scheduled jobs and hosted docs" tells hiring teams you understand
the full production workflow — not just the SQL.

See `docs/cloud_migration_plan.md` for the concrete step list.
