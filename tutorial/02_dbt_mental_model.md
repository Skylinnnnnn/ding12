# 02 — The dbt Mental Model

If you already write SQL, dbt is smaller than it looks. Here's the whole idea.
Official reference: [dbt docs → Build](https://docs.getdbt.com/docs/build/projects).

## A model is a SELECT
Every `.sql` file in `models/` is a single `SELECT` statement. dbt wraps it in
`CREATE VIEW` or `CREATE TABLE` for you based on the configured materialization.
You never write DDL. → [dbt docs: Models](https://docs.getdbt.com/docs/build/models)

## `ref()` builds the dependency graph
Instead of hardcoding table names, models reference each other:

```sql
select * from {{ ref('stg_orders') }}
```

dbt uses these `ref()`s to (a) figure out the correct build order and (b) draw
the lineage graph. Change a name in one place and everything downstream follows.
→ [dbt docs: `ref()`](https://docs.getdbt.com/reference/dbt-jinja-functions/ref)

## Seeds are CSVs loaded as tables
`dbt seed` loads the files in `seeds/` into the warehouse. Good for small, static,
version-controlled data — which is exactly our Olist CSVs.
→ [dbt docs: Seeds](https://docs.getdbt.com/docs/build/seeds)

## Materializations
| Config | What dbt creates | We use it for |
| --- | --- | --- |
| `view` | a view (query re-runs each time) | staging, intermediate |
| `table` | a physical table (built once per run) | marts |

Views keep the intermediate layers thin and always-fresh; marts are tables so
dashboards read fast. → [dbt docs: Materializations](https://docs.getdbt.com/docs/build/materializations)

## Tests are assertions
Tests are declared in `schema.yml` (e.g. `unique`, `not_null`, `relationships`,
`accepted_values`) or written as singular SQL in `tests/`. A test **passes when
it returns zero rows**. `dbt test` runs them all.
→ [dbt docs: Data tests](https://docs.getdbt.com/docs/build/data-tests)

## Docs and lineage
`dbt docs generate` + `dbt docs serve` produce a browsable site showing every
model, its description, its columns, its tests, and a visual DAG of `ref()`s.
→ [dbt docs: Documentation](https://docs.getdbt.com/docs/build/documentation)

## The layers (our convention)
- **staging** — one model per source table; clean, cast, rename. No business
  logic. Named `stg_*`.
- **intermediate** — reusable joins and business logic. Named `int_*`.
- **marts** — aggregated, business-facing outputs. Named `mart_*`.

That layering is the single most important habit to take away: **each layer has
one job**, so models stay small and reviewable.
