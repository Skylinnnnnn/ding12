# Resume Bullet Examples

Pick and tailor. Numbers refer to the Olist dataset (~100k orders, ~3k sellers,
~70 product categories); adjust to what you actually cite.

## Business Analyst / Data Analyst
- Built a marketplace analytics project on ~100k e-commerce orders, translating
  raw transactional data into six decision-ready reporting layers (growth,
  seller, delivery, CX, category, payments).
- Defined and documented core marketplace KPIs (GMV, AOV, completion and
  cancellation rates, late-delivery rate, review scores) in a shared glossary.

## BI Analyst / Business Intelligence Engineer
- Built and shipped a live, multi-page analytics dashboard (Evidence) on top of
  dbt marts — executive overview, seller, delivery, customer experience, and
  category views — publicly deployed via GitHub Actions to GitHub Pages.
- Modeled daily/monthly reporting grains so the dashboard reads pre-aggregated
  tables instead of recomputing metrics on the fly, and documented every metric
  in a shared glossary.

## Analytics Engineer / technical analyst
- Engineered a dbt (Core) + DuckDB project with a staging → intermediate → marts
  architecture, `ref()`-based lineage, and reusable macros.
- Implemented a data-quality test suite — uniqueness, not-null, referential
  integrity across the order graph, accepted-values, and custom singular tests —
  and generated lineage/documentation with dbt docs.
- Automated deployment with a GitHub Actions pipeline that rebuilds the warehouse
  from version-controlled seeds and publishes the dashboard on every push to main.

## Marketplace / Operations Analytics
- Quantified delivery reliability (late-delivery rate, delay days,
  purchase-to-delivery time) and linked it to customer review scores to flag
  high-GMV sellers posing customer-experience risk.
- Segmented category and payment behavior to inform assortment and financing
  decisions.
