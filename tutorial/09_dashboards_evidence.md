# 09 — Dashboards with Evidence

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

## One-time setup
Install the Evidence project's dependencies:

```bash
# from the repo root
cd reports
npm install
```

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

## Deploying — automated GitHub Pages
This repo ships a GitHub Actions workflow (`.github/workflows/deploy.yml`) that
**auto-publishes the dashboard on every push to `main`**. The workflow:
1. installs dbt and builds `ding12.duckdb` from the committed seeds,
2. installs Evidence deps and builds the static site (with base path `/ding12`),
3. deploys it to GitHub Pages.

Live URL: **https://skylinnnnnn.github.io/ding12/**

**One-time repo setting:** in GitHub → **Settings → Pages → Build and deployment**,
set **Source = GitHub Actions** (the workflow's `configure-pages` step usually
enables this automatically on the first run).

Because it builds from the committed seeds, the deploy needs no secrets and no
Kaggle download. `npm run build` still works locally too (outputs to
`reports/build/`) if you'd rather host on Evidence Cloud, Netlify, or Vercel.
