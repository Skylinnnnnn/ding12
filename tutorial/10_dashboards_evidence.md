# 10 — Dashboards with Evidence

The `dashboards/*.md` files are dashboard **specs** (blueprints). The `reports/`
folder is the **live implementation** built with [Evidence](https://evidence.dev),
a code-based BI tool: you write SQL + markdown, and it renders interactive charts.
It reads directly from the dbt-built `ding12.duckdb`, so the dashboards always
reflect the same tested marts.

## Prerequisites
- You must have run **`dbt build`** at least once, so `ding12.duckdb` exists with
  the `mart_*` tables.
- **Node.js 18+**:
  - **Windows:** `winget install OpenJS.NodeJS.LTS` (or download from nodejs.org)
  - **macOS:** `brew install node`
  - Check with `node --version`.

## One-time setup — scaffold the project  📋 copy the scaffold, ✍️ write the pages
Don't hand-write the Evidence scaffold — generate it with the official template,
then delete the sample source:

```bash
# from the repo root
npx degit evidence-dev/template reports
cd reports
npm install
rm -rf sources/needful_things        # remove the sample data source
```

Now wire it to your marts (these are small — write them, referencing the
[reference `reports/`](https://github.com/Skylinnnnnn/ding12/tree/main/reports)):
- 📋 `sources/ding12/connection.yaml` — points at `../../../ding12.duckdb`.
- ✍️ `sources/ding12/*.sql` — one line each: `select * from mart_<name>`.
- ✍️ `pages/*.md` — the dashboard pages (SQL blocks + `<LineChart>`, `<BigValue>`,
  `<DataTable>`…). This is the fun part — see the
  [Evidence components docs](https://docs.evidence.dev/components/all-components/).

## Run it (local dev server)
```bash
# from the reports/ folder
npm run dev
```
Open **http://localhost:3000**. Edit any file in `reports/pages/` and the browser
updates live. Press **Ctrl+C** to stop.

> **Windows note:** run the same `npm` commands in PowerShell or Command Prompt
> from the `reports\` folder. Node/npm commands are identical across OSes.

## How it's wired
```
reports/
├── sources/ding12/
│   ├── connection.yaml         # points at ../../../ding12.duckdb
│   └── *.sql                   # one query per mart (select * from mart_*)
└── pages/
    ├── index.md                # Executive Overview (landing page)
    ├── seller_performance.md
    ├── delivery_reliability.md
    ├── customer_experience.md
    └── category_performance.md
```
- Each `.sql` in `sources/ding12/` exposes a mart to the pages as
  `ding12.<filename>` (e.g. `ding12.seller_performance`).
- Pages query those with ```` ```sql ```` blocks and render components like
  `<LineChart>`, `<BarChart>`, `<BigValue>`, `<ScatterPlot>`, `<DataTable>`.

## When the data changes
If you re-run `dbt build`, refresh the dashboard data:
```bash
cd reports
npm run sources     # re-pull the marts from DuckDB
# (npm run dev already re-pulls on start)
```

> **One process per DuckDB file.** Evidence reads `ding12.duckdb`; don't run
> `dbt build` at the exact same moment or you may hit a lock error. Run them
> one at a time.

## Deploying — automated GitHub Pages  📋 copy, then adjust for your repo
A GitHub Actions workflow (`.github/workflows/deploy.yml`) **auto-publishes the
dashboard on every push to `main`**. The workflow:
1. installs dbt and builds `ding12.duckdb` from the committed seeds,
2. materializes Evidence sources and builds the static site (with a base path),
3. deploys it to GitHub Pages.

📋 **Copy** [`.github/workflows/deploy.yml`](https://github.com/Skylinnnnnn/ding12/blob/main/.github/workflows/deploy.yml)
— it's infrastructure, not something to author by hand. **But adjust two things
for your own repo:**
- the **base path** must equal `/<your-repo-name>` (the "Set base path" step),
- your live URL will be **`https://<your-username>.github.io/<your-repo-name>/`**.

> ⚠️ **The `npm run sources` step is essential.** `evidence build` does *not*
> materialize the data — without a sources step the deployed site loads but every
> query fails ("Timeout while initializing database"). Ask me how I know. 🙂

**One-time repo setting:** in GitHub → **Settings → Pages → Build and deployment**,
set **Source = GitHub Actions** (the workflow's `configure-pages` step usually
enables this automatically on the first run). Pushing a workflow file also needs
the `workflow` scope on your login — if `git push` is rejected, run
`gh auth refresh -h github.com -s workflow`.

Because it builds from the committed seeds, the deploy needs no secrets and no
Kaggle download. `npm run build` still works locally too (outputs to
`reports/build/`) if you'd rather host on Evidence Cloud, Netlify, or Vercel.

## 🎉 You've built the whole thing
That's the full track: from an empty repo to a tested, documented dbt warehouse
with a live dashboard on the internet. You now have a portfolio project with a
public URL you can put on a resume — built with the exact tools modern data teams
use.

**Where to go next:** [`../docs/next_steps.md`](../docs/next_steps.md) is the
roadmap for leveling it up — running the same project on a real cloud warehouse
(BigQuery/Snowflake) with scheduled jobs and CI. Read [`11_dbt_cloud_bigquery.md`](11_dbt_cloud_bigquery.md)
first for the mental model of that jump. And revisit [`../docs/interview_story.md`](../docs/interview_story.md)
and [`../docs/resume_bullets.md`](../docs/resume_bullets.md) to turn the build into
something you can talk about.
