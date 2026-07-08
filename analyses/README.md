# analyses/

Ad-hoc analytical SQL that you want version-controlled but **not** materialized
as models. `dbt compile` will render these (resolving `ref()`s and macros) so you
can copy the final SQL into a BI tool or query editor, but `dbt run` does not
build them.

Use this folder for exploratory queries, one-off investigations, and
metric-validation scratch work.
