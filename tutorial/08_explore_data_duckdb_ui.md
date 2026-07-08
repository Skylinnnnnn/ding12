# 08 — Explore the Data Visually (DuckDB UI)

Once you've run `dbt build`, all the seeds, views, and mart tables live inside a
single file: `ding12.duckdb`. You don't need the command line to look at them —
DuckDB ships a **built-in browser UI**.

## Easiest: the project launcher script
With the virtual environment active (see below), from the repo root:

```bash
python scripts/open_ui.py
```

This opens **http://localhost:4213** in your browser. In the left sidebar, expand
the **ding12** database to see every table and view:
- the raw seeds (`olist_*`)
- staging views (`stg_*`)
- intermediate views (`int_*`)
- the six mart tables (`mart_*`)

Click any table to preview rows, or open a SQL cell and run queries like:

```sql
select * from mart_daily_marketplace_metrics order by order_date desc limit 20;
select * from mart_seller_performance order by seller_gmv desc limit 20;
```

Results can be viewed as a table or a quick chart. Press **Ctrl+C** in the
terminal to stop the UI.

### Activating the virtual environment first
- **Windows (PowerShell):** `.venv\Scripts\Activate.ps1`
- **Windows (Command Prompt):** `.venv\Scripts\activate.bat`
- **macOS / Linux:** `source .venv/bin/activate`

## Try it: a sample query that tells a story (zero extra setup)
You can do real analysis right here — no dashboard needed. In the DuckDB UI, open
a new SQL cell, paste this, and run it:

```sql
select
    order_month,
    delivered_orders,
    round(late_delivery_rate * 100, 1) as late_pct,
    round(avg_delivery_delay_days, 1)  as avg_delay_days
from mart_delivery_reliability
order by order_month;
```

Then **switch the result from table view to the chart view** (the chart toggle
above the results) and put `order_month` on the x-axis and `late_pct` on the
y-axis.

**What the data is telling you:**
- **March 2018 spikes to a ~21.4% late rate** — far above neighboring months. That
  is exactly the kind of anomaly worth investigating (a carrier issue? a demand
  surge? a specific region or seller?). Finding the *question* is the analyst's job.
- **`avg_delay_days` is negative in most months.** Delay is *actual delivery date
  minus the estimated date*, so negative means orders typically arrive **ahead of
  schedule** — Olist's delivery estimates are conservative. Good to know before you
  report "late deliveries," because "late vs. the estimate" and "slow" are different
  things.

That's genuine analysis — a trend, an anomaly, and an assumption to document —
straight from a SQL cell. The polished dashboard in `reports/` (see
[`09_dashboards_evidence.md`](09_dashboards_evidence.md)) just makes this shareable.

> Try the same move on `mart_seller_performance` (sort by `seller_gmv`, eyeball
> `avg_review_score` and `late_delivery_rate`) or `mart_category_performance`
> (which categories pair high GMV with low review scores?).

## Alternative: the DuckDB CLI
If you install the standalone DuckDB CLI, you can launch the same UI directly:

```bash
duckdb ding12.duckdb -ui
```

Install the CLI:
- **Windows:** `winget install DuckDB.cli` (or download the exe from duckdb.org)
- **macOS:** `brew install duckdb`

## Alternative: DBeaver (a full database GUI)
If Ding lao shi prefers a traditional SQL-workbench experience (like SSMS or
DBeaver for other databases), **DBeaver Community** is free and cross-platform:
1. Install DBeaver (Windows/macOS/Linux).
2. New connection → **DuckDB**.
3. Point the database path at `ding12.duckdb` in the repo.
4. Browse tables and write SQL with autocomplete.

> **Only one process can open the DuckDB file at a time.** Close `dbt` runs and
> any other UI before connecting, or you may see a lock error. Stop the DuckDB UI
> (Ctrl+C) before running `dbt build`, and vice versa.

## Why this matters
For a data analyst, being able to *see* the tables — sort, filter, eyeball
distributions — builds trust in the models far faster than reading SQL. It's also
the natural place to sanity-check a metric before putting it on a dashboard.
