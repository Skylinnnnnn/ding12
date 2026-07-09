# 08 — dbt Docs: the Local UI

dbt can generate a browsable documentation site from your project — model
descriptions, columns, tests, and a visual lineage graph. This is one of the
most portfolio-friendly features in the whole stack.

## Generate and serve
```bash
dbt docs generate     # builds the docs artifacts from your project + warehouse
dbt docs serve        # starts a local web server and opens the site
```

`dbt docs serve` runs a local server (default `http://localhost:8080`). Stop it
with `Ctrl+C` when you're done.

## What you'll see
- **Every model** with its description and column-level docs (pulled from the
  `schema.yml` files).
- **Tests** attached to each model, so a reviewer can see the data-quality
  guarantees at a glance.
- **The lineage graph (DAG)** — a visual map of how seeds flow into staging,
  intermediate, and marts via `ref()`.

## What "lineage" means
Lineage is the dependency graph: for any model, you can see everything upstream
(what it's built from) and downstream (what depends on it). Click a mart and
trace it all the way back to the raw seeds. This is how teams answer "if I change
this column, what breaks?"

## Why this matters for portfolio review
When an interviewer or hiring manager opens your project, the docs site instantly
communicates that you think in terms of **tested, documented, dependency-managed
pipelines** — not one-off queries. It's the fastest way to show analytics-
engineering maturity without walking through code line by line.
