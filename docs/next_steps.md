# Next Steps — After the Tutorial (Learning Roadmap / TODO)

You've finished the local MVP: dbt Core + DuckDB, tested and documented, with a
live dashboard on GitHub Pages. That already proves the *analytics* works. This
file is the **TODO for what to build next** to make it look like a real
industry workflow.

The theme of every step below is the same: **the models don't change — you're
learning the connections around them.** Local dbt taught you the transformation
layer. The next phase teaches you the *plumbing* that tech data teams actually
run: GitHub → dbt → a real cloud warehouse → scheduled jobs → CI.

---

## ⭐ Next step: run the SAME project on a real cloud warehouse

This is the highest-value move and the one to do first. Point the identical dbt
project at a managed cloud warehouse instead of the local DuckDB file. You reuse
**all** your models, `ref()`s, tests, and marts — the only new thing you learn is
the **connection chain**, which is exactly what's missing from a local-only
project:

```
your laptop → GitHub repo → dbt → cloud data warehouse → scheduled job + CI
```

Being able to say *"I built it locally to prove the logic, then ran the identical
dbt project on a real cloud warehouse with scheduled jobs and PR checks"* is what
signals you understand the **full production workflow**, not just SQL.

### Which warehouse? BigQuery first, Snowflake optional

| Option | Why | Watch out |
| --- | --- | --- |
| **BigQuery** ⭐ (recommended first) | **Permanent free tier** (10 GB storage + 1 TB queries/month, free forever) — your portfolio keeps working indefinitely. Easiest OAuth/service-account setup. | Google Cloud project setup has a few steps. |
| **Snowflake** (do it second, to compare) | The most common warehouse in tech-company job postings — great résumé keyword and worth hands-on familiarity. | Free trial is **30 days / $400 credits, then it expires** — don't make it your *live* demo, or the demo dies with the trial. |

**Recommendation:** make **BigQuery** the permanent home for the live/deployed
version (so it stays up for free), then optionally spin up a **Snowflake** trial
for a couple of weeks just to experience its connection + syntax differences. The
dbt project runs on both with only tiny dialect tweaks.

### How you'd run dbt against it — two paths

1. **dbt Core (local) with a cloud target** — keep running `dbt` from your
   terminal, but add a `bigquery` (or `snowflake`) target in `profiles.yml`
   alongside the DuckDB one. Cheapest, closest to what you already do. Good for
   learning the *connection* itself.
2. **dbt Cloud** — the browser IDE + managed environments + built-in scheduler +
   hosted docs. This is where you learn the *managed* workflow. See
   [`../tutorial/07_dbt_cloud_bigquery.md`](../tutorial/07_dbt_cloud_bigquery.md)
   and the concrete step list in
   [`cloud_migration_plan.md`](cloud_migration_plan.md).

Do path 1 first (you'll really understand the auth/connection), then path 2 (you
get scheduling and hosted docs "for free").

### TODO checklist for this step
- [ ] Create a Google Cloud project + a BigQuery dataset (free tier).
- [ ] Load the Olist CSVs into BigQuery tables (`bq load`, console upload, or a
      small load script) — or use `dbt seed` against the BigQuery target.
- [ ] Add a `bigquery` target to `profiles.yml` (service account JSON or OAuth);
      keep the DuckDB target too so local still works.
- [ ] `dbt debug` against BigQuery → green.
- [ ] `dbt build` on BigQuery; fix any small dialect differences (date/functions).
- [ ] `dbt docs generate` and browse lineage against the cloud warehouse.
- [ ] (dbt Cloud) Connect the GitHub repo, create a scheduled **job** running
      `dbt build`, and enable **CI checks on pull requests**.
- [ ] Screenshot it and add a short "Cloud version" section to the README.

---

## After that — the rest of the industry workflow

Once it runs on a real warehouse, these are the natural follow-ons (roughly in
priority order):

- [ ] **CI on pull requests.** Make `dbt build` run automatically on every PR
      (dbt Cloud CI, or a GitHub Actions job) so bad models never merge. You
      already have Actions experience from the Pages deploy — this extends it.
- [ ] **Scheduling / orchestration.** A daily scheduled `dbt build` (dbt Cloud
      Jobs is the easy start; Airflow/Dagster/Prefect are the heavier industry
      tools to *read about* now, build later).
- [ ] **Incremental models & snapshots.** Learn `materialized='incremental'` for
      large fact tables and dbt **snapshots** for slowly-changing dimensions —
      the two dbt features you skip in a small local project but need at scale.
      → [Incremental models](https://docs.getdbt.com/docs/build/incremental-models)
      · [Snapshots](https://docs.getdbt.com/docs/build/snapshots)
- [ ] **Sources & freshness.** Declare `sources:` (instead of seeds) and add
      `dbt source freshness` checks — how real projects ingest upstream data.
      → [Sources](https://docs.getdbt.com/docs/build/sources)
- [ ] **Exposures / semantic layer.** Declare the dashboard as a dbt `exposure`
      so lineage runs end-to-end from raw → mart → BI.
      → [Exposures](https://docs.getdbt.com/docs/build/exposures)

## Optional stretch (plays to your BI background)
- [ ] Connect a **BI tool you'll see in job postings** — Looker, Tableau, or
      Power BI — directly to the cloud marts, alongside the Evidence dashboard.
      You already have deep BI instincts; this just points them at the new stack.
- [ ] **Data-quality tooling** beyond dbt tests: explore
      [Elementary](https://www.elementary-data.com/) or Great Expectations.
- [ ] **Reverse ETL / activation** concepts — how marts get pushed back into
      operational tools (read-level familiarity is enough for now).

---

## How to use this list
Don't do it all at once. The ⭐ cloud-warehouse step is the one that changes how
your project *reads* to a hiring manager — do that fully first. Everything under
"the rest of the industry workflow" is a menu: pick what maps to the roles you're
targeting (check the job descriptions — if they say "Snowflake" and "Airflow,"
prioritize those). Keep the same habit as the tutorial: **build it into your own
repo, one piece at a time, and understand each connection before moving on.**
