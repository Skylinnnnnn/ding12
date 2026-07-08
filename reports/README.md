# Ding12 — Evidence Dashboard

The live, interactive dashboard for the Ding12 marketplace analytics project,
built with [Evidence](https://evidence.dev). It reads directly from the dbt-built
`ding12.duckdb` (one level up in the repo root) and renders charts from SQL +
markdown.

**Live:** https://skylinnnnnn.github.io/ding12/ — auto-deployed from `main` by
`.github/workflows/deploy.yml`.

## Run it locally
Prerequisites: run `dbt build` in the repo root first (so `ding12.duckdb` exists),
and have **Node.js 18+** installed.

```bash
# from this reports/ folder
npm install        # one time
npm run sources    # materialize the marts to parquet (required before dev/build)
npm run dev        # http://localhost:3000  (Ctrl+C to stop)
```

## Layout
```
reports/
├── sources/ding12/          # connection.yaml -> ../../../ding12.duckdb + one .sql per mart
├── pages/                   # the dashboard pages (index = Executive Overview)
└── evidence.config.yaml     # theme + plugins (basePath is set only in CI)
```
Each `.sql` in `sources/ding12/` exposes a mart as `ding12.<name>` to the pages.

Full walkthrough (Windows + macOS): [`../tutorial/09_dashboards_evidence.md`](../tutorial/09_dashboards_evidence.md).

## Notes
- **One process per DuckDB file:** stop `npm run dev` before running `dbt build`.
- `npm run build` outputs a static site to `build/` (what CI publishes).
- Evidence docs: https://docs.evidence.dev/
