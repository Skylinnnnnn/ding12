# Cloud Migration Plan (Future Polish)

**dbt Cloud + BigQuery is a future polish phase, not part of the local MVP.** The
local project is complete and interview-ready on its own. The cloud phase mirrors
a more production-like workflow; it should **not block** the portfolio MVP.

## Stage 1 — Local MVP (this repo, done)
- dbt Core + DuckDB, run entirely locally.
- GitHub repo is the source of truth.
- Seeds → staging → intermediate → marts, with tests and docs.
- Inspect lineage and documentation with `dbt docs serve` locally.
- Explore the data in the DuckDB browser UI.
- A live Evidence dashboard on the marts, auto-deployed to GitHub Pages via
  GitHub Actions (https://skylinnnnnn.github.io/ding12/). This is a lightweight,
  free deployment — the Stage 2 polish below swaps the *warehouse and execution*
  layer, not the dashboard.

## Stage 2 — dbt Cloud + BigQuery polish
1. Push the repo to GitHub (already the source of truth).
2. Create a **dbt Cloud** project and connect the GitHub repo.
3. Create a **Google Cloud / BigQuery** sandbox project and dataset.
4. Load the Olist CSVs into BigQuery tables (BigQuery console upload, `bq load`,
   or a small load script).
5. Configure the dbt Cloud **BigQuery connection** (service account / OAuth) and
   a `bigquery` profile target.
6. Run the **same** dbt workflow (`seed`/`build`/`test`) in dbt Cloud.
7. Generate docs and lineage in the dbt Cloud UI; add a scheduled job.
8. Capture screenshots and notes in the README.

## What changes vs. what stays the same
**Changes:** the warehouse (DuckDB → BigQuery), where compute runs (laptop →
cloud), and the execution surface (terminal → dbt Cloud browser IDE + managed
environments, jobs, and scheduling).

**Stays the same:** the models, `ref()`s, tests, marts, metric definitions, and
the GitHub repo structure. That portability is exactly the point — the analytics
logic is warehouse-agnostic.

## Why this matters for analytics roles at tech companies
It demonstrates that the same governed, tested transformation layer runs on a
real cloud warehouse with CI-style jobs and managed docs — the setup most modern
data teams actually use.
