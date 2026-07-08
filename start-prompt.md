You are helping me build a job-search-first analytics portfolio project in my local GitHub repo named Ding12.

Context:
This project is for a Senior Data Analyst with strong SQL, ETL, and business analytics background, but limited experience with Git, GitHub, terminal, dbt, CI/CD, and modern analytics engineering workflows.

The goal is not to turn her into a Data Engineer or build a huge data engineering bootcamp. The goal is to quickly create a clean, reproducible, interview-friendly analytics portfolio project using SQL, dbt, DuckDB, GitHub, and clear documentation.

This project should be practical for Business Analyst, Data Analyst, BI Analyst, Business Intelligence Engineer, Marketing Analytics, Customer Insights, Marketplace Analytics, Operations Analytics, Revenue Analytics, and GTM Analytics roles.

Dataset:
Use Kaggle dataset: Brazilian E-Commerce Public Dataset by Olist
Kaggle dataset slug: olistbr/brazilian-ecommerce

Important:
I will download the dataset manually from Kaggle. Do not use the Kaggle API to download the data unless I explicitly ask later.

Manual download workflow to document:

1. Open Kaggle.
2. Search for Brazilian E-Commerce Public Dataset by Olist.
3. Open dataset slug: olistbr/brazilian-ecommerce.
4. Click Download.
5. Unzip the downloaded file.
6. Copy the CSV files into the repo’s seeds/ folder.
7. Confirm that the expected CSV files exist before running dbt seed.

Expected files in seeds/:

- olist_customers_dataset.csv
- olist_geolocation_dataset.csv
- olist_order_items_dataset.csv
- olist_order_payments_dataset.csv
- olist_order_reviews_dataset.csv
- olist_orders_dataset.csv
- olist_products_dataset.csv
- olist_sellers_dataset.csv
- product_category_name_translation.csv

For the MVP, use all except geolocation. Keep geolocation in the folder if present, but do not model it yet unless it is trivial.

Project theme:
Commerce marketplace analytics.

Final positioning:
Ding12 is a commerce marketplace analytics project that transforms raw Olist marketplace data into tested, documented, dashboard-ready marts for marketplace growth, seller performance, delivery reliability, customer experience, category performance, and payment behavior.

Important constraints:

- Keep the project simple and runnable locally.
- Use DuckDB for the MVP, not Postgres or a cloud warehouse.
- Use dbt Core with dbt-duckdb.
- Use VS Code and terminal as the main development environment.
- Keep the GitHub repo as the source of truth.
- Do not add Airflow, Spark, Docker, cloud infrastructure, or complex CI/CD yet.
- Do not make dbt Fusion a requirement.
- Do not implement dbt Cloud yet.
- Do document dbt Cloud + BigQuery as an important future polish phase.
- Do not rely on Kaggle API for the MVP.
- Focus on getting an MVP working end-to-end.
- Prefer clear SQL, clear model layering, tests, documentation, and business insight over fancy tooling.
- Do not delete existing repo files unless clearly safe.

High-level learning goal:
This project should help a strong Senior Data Analyst understand how modern analytics projects are structured:

- GitHub repo as source of truth
- VS Code as editor
- terminal as execution interface
- DuckDB as local analytics database
- dbt as SQL transformation framework
- staging/intermediate/marts as the modeling pattern
- dbt tests as data quality checks
- dbt docs as local UI for lineage and documentation
- dashboard specs as business-facing outputs
- dbt Cloud + BigQuery as a future production-like polish path

Step 1: Inspect the repo.

- Confirm we are inside the Ding12 repo.
- Print the current repo path.
- Print the current file structure.
- Do not delete existing files unless clearly safe.
- Create missing folders and files as needed.

Step 2: Create or complete this project structure.

Ding12/
README.md
requirements.txt
.gitignore
dbt_project.yml
profiles.example.yml

seeds/
schema.yml

models/
staging/
schema.yml
intermediate/
schema.yml
marts/
schema.yml

analyses/
dashboards/
docs/
tutorial/
macros/
tests/

Step 3: Create requirements.txt.

Include:
dbt-core
dbt-duckdb
duckdb
pandas

Do not include kaggle for now because I am downloading the data manually.

Step 4: Create .gitignore for Python, dbt, DuckDB, local artifacts, and secrets.

Include:
.venv/
**pycache**/
.DS_Store
target/
dbt_packages/
logs/
_.duckdb
_.duckdb.wal
.env
kaggle.json
\*.zip

Step 5: Do not download data automatically.

Instead:

- Check whether the expected CSV files already exist in seeds/.
- Print which expected files are present.
- Print which expected files are missing.
- If files are missing, stop before running dbt seed and clearly tell me to manually download the Kaggle dataset, unzip it, and copy the CSV files into seeds/.
- Do not block the creation of project files just because data is not present.
- Create all dbt project files and docs regardless of whether the CSV files are already present.

Manual Kaggle download instructions to include in README and tutorial/01_environment_setup.md:

1. Go to Kaggle.
2. Search for Brazilian E-Commerce Public Dataset by Olist.
3. Open dataset slug: olistbr/brazilian-ecommerce.
4. Click Download.
5. Unzip the downloaded file.
6. Copy all CSV files into the seeds/ folder.
7. Confirm the CSV files are directly under seeds/, not inside a nested downloaded folder.
8. Run dbt seed.

Step 6: Create dbt_project.yml.

Use:

- project name: ding12
- profile: ding12
- model paths: models
- seed paths: seeds
- analysis paths: analyses
- macro paths: macros
- test paths: tests

Configure:

- staging models as views
- intermediate models as views
- marts as tables

Step 7: Create profiles.example.yml for DuckDB.

Content should define:
ding12:
target: dev
outputs:
dev:
type: duckdb
path: ding12.duckdb
threads: 4

Also add README instructions telling the user to copy profiles.example.yml into ~/.dbt/profiles.yml for local development.

Step 8: Create seeds/schema.yml.

Add lightweight descriptions for the main Olist seed files:

- olist_customers_dataset
- olist_orders_dataset
- olist_order_items_dataset
- olist_order_payments_dataset
- olist_order_reviews_dataset
- olist_products_dataset
- olist_sellers_dataset
- product_category_name_translation

Do not over-document every single column yet. Make it readable and useful for portfolio review.

Step 9: Create staging models.

Create these files:

models/staging/stg_customers.sql
models/staging/stg_orders.sql
models/staging/stg_order_items.sql
models/staging/stg_order_payments.sql
models/staging/stg_order_reviews.sql
models/staging/stg_products.sql
models/staging/stg_sellers.sql
models/staging/stg_product_category_translation.sql

Staging model rules:

- Reference seeds using dbt ref.
- Use the seed relation names without .csv.
- Example: ref('olist_orders_dataset')
- Rename columns only where helpful.
- Cast timestamps and dates explicitly.
- Standardize basic string fields using lower/trim where useful.
- Do not create complex business metrics in staging.
- Keep SQL readable.
- Staging should be the clean standardized version of raw data, not the business logic layer.

Step 10: Create models/staging/schema.yml.

Add basic tests:

- unique + not_null for customer_id in stg_customers
- unique + not_null for order_id in stg_orders
- unique + not_null for seller_id in stg_sellers
- unique + not_null for product_id in stg_products

Add accepted_values tests where practical:

- order_status
- payment_type
- review_score

Add relationship tests:

- stg_orders.customer_id -> stg_customers.customer_id
- stg_order_items.order_id -> stg_orders.order_id
- stg_order_items.seller_id -> stg_sellers.seller_id
- stg_order_items.product_id -> stg_products.product_id
- stg_order_payments.order_id -> stg_orders.order_id
- stg_order_reviews.order_id -> stg_orders.order_id

Important:
Some Olist tables have duplicate order_id rows, such as payments, reviews, and order_items. Do not add unique tests to non-unique columns.

If a test fails because the real dataset does not match our assumption, fix the assumption rather than forcing the data to pass.

Step 11: Create intermediate models.

Create these files:

models/intermediate/int_orders_enriched.sql
models/intermediate/int_order_delivery_performance.sql
models/intermediate/int_seller_order_performance.sql
models/intermediate/int_review_experience.sql
models/intermediate/int_category_performance.sql

Definitions:

int_orders_enriched:

- Join orders to customers.
- Add order_date, order_month, and order_week.
- Add completed_order_flag.
- Add canceled_order_flag.
- Keep order status and timestamps.
- Keep customer city/state.
- Grain should be one row per order.

int_order_delivery_performance:

- Start from orders.
- Calculate purchase_to_delivered_days.
- Calculate estimated_delivery_days.
- Calculate delivery_delay_days as actual delivered date minus estimated delivery date.
- Calculate late_delivery_flag.
- Only calculate actual delivery metrics where delivered timestamp exists.
- Grain should be one row per order.

int_seller_order_performance:

- Join order_items, orders, sellers, products, and category translation if available.
- Include order item revenue fields at order-item grain.
- Include seller city/state, product category, price, and freight_value.
- Grain should be one row per order item.

int_review_experience:

- Join orders, reviews, and delivery performance.
- Include review_score, late_delivery_flag, and delivery_delay_days.
- Prepare for customer experience analysis.
- Grain should be one row per review or one row per reviewed order, depending on what the Olist data supports. Document the chosen grain.

int_category_performance:

- Join order_items, products, category translation, and orders.
- Include category, price, freight, order status, and order date.
- Grain should be one row per order item.

Step 12: Create intermediate schema.yml.

Add short model descriptions and basic column descriptions for each intermediate model.

Do not overdo documentation. Prioritize:

- grain
- primary business purpose
- key calculated fields

Step 13: Create mart models.

Create these files:

models/marts/mart_daily_marketplace_metrics.sql
models/marts/mart_seller_performance.sql
models/marts/mart_delivery_reliability.sql
models/marts/mart_customer_experience.sql
models/marts/mart_category_performance.sql
models/marts/mart_payment_behavior.sql

Definitions:

mart_daily_marketplace_metrics:
Grain: order_date.
Metrics:

- gross_orders
- completed_orders
- canceled_orders
- completion_rate
- cancellation_rate
- total_gmv
- total_freight
- avg_order_value
- active_customers

Business note:
GMV should be based on order item price and freight where possible. If payment value is used, document the assumption.

mart_seller_performance:
Grain: seller_id.
Metrics:

- seller_orders
- completed_orders
- seller_gmv
- avg_item_price
- total_freight
- avg_freight
- distinct_products_sold
- avg_review_score if available
- late_delivery_rate if available

Business note:
This mart should help identify sellers who are high value but may create customer experience risk.

mart_delivery_reliability:
Grain: order_month.
Metrics:

- delivered_orders
- late_orders
- late_delivery_rate
- avg_delivery_delay_days
- avg_purchase_to_delivered_days

Business note:
This mart should help explain operational reliability and customer experience risk.

mart_customer_experience:
Grain: order_month.
Metrics:

- review_count
- avg_review_score
- low_review_count
- low_review_rate
- late_delivery_rate
- avg_delivery_delay_days

Business note:
Low review can be defined as review_score <= 2. Document this assumption.

mart_category_performance:
Grain: product_category_name_english.
Metrics:

- orders
- items_sold
- category_gmv
- avg_item_price
- avg_freight
- avg_review_score if available

mart_payment_behavior:
Grain: payment_type.
Metrics:

- orders
- payment_records
- total_payment_value
- avg_payment_value
- avg_payment_installments

Use nullif to avoid divide-by-zero errors.

Step 14: Create models/marts/schema.yml.

Add descriptions for all mart models.

For each mart, document:

- grain
- business purpose
- key metrics
- dashboard use case

Add tests where practical:

- not_null on primary grain columns
- accepted values where useful
- basic data sanity tests if easy

Step 15: Create macro.

Create:
macros/safe_divide.sql

Macro content:
{% macro safe_divide(numerator, denominator) %}
{{ numerator }} / nullif({{ denominator }}, 0)
{% endmacro %}

Use it where helpful, but do not overcomplicate the project.

Step 16: Create custom singular tests if useful.

Create:
tests/assert_positive_order_amounts.sql
tests/assert_valid_delivery_timestamps.sql

Rules:

- Only add tests that are easy to explain.
- Do not add fragile tests that create unnecessary MVP blockers.
- If a test fails because the dataset has real-world messiness, either update the test or document the finding.

Step 17: Create short docs.

Create these files:

docs/metrics_glossary.md
docs/business_assumptions.md
docs/interview_story.md
docs/resume_bullets.md
docs/cloud_migration_plan.md

docs/metrics_glossary.md should define:

- gross orders
- completed orders
- canceled orders
- completion rate
- cancellation rate
- GMV
- freight
- AOV
- late delivery flag
- delivery delay days
- average review score
- low review rate

docs/business_assumptions.md should explain:

- This is a marketplace analytics portfolio project using public Olist data.
- Olist is e-commerce, but the business concepts map well to marketplace analytics.
- Sellers are treated as merchants.
- Delivery reliability is measured using actual vs estimated delivery dates.
- Customer experience is proxied by review scores.
- GMV assumptions should be clearly documented.
- Geolocation is excluded from MVP to keep scope controlled.

docs/interview_story.md should include:

- 60-second project pitch
- 3-minute project deep dive
- Why dbt
- Why DuckDB
- How data quality was handled
- Example business insights
- What would be improved next

docs/resume_bullets.md should include resume bullet examples for:

- Business Analyst / Data Analyst
- BI Analyst / Business Intelligence Engineer
- Analytics Engineer / technical analyst
- Marketplace / Operations Analytics

docs/cloud_migration_plan.md should explain that dbt Cloud + BigQuery is an important future polish phase, not part of the local MVP.

It should include:

Stage 1: Local MVP

- Use dbt Core + DuckDB locally.
- Keep the GitHub repo as the source of truth.
- Build seeds, staging models, intermediate models, marts, tests, docs, and dashboard specs.
- Use dbt docs locally to inspect lineage and model documentation.

Stage 2: dbt Cloud + BigQuery polish

- Push the repo to GitHub.
- Create a dbt Cloud project.
- Connect the GitHub repo to dbt Cloud.
- Create a Google Cloud / BigQuery sandbox or project.
- Load the Olist CSV files into BigQuery tables.
- Configure the dbt Cloud BigQuery connection.
- Run the same dbt transformation workflow in dbt Cloud.
- Generate dbt docs and lineage in the dbt Cloud UI.
- Add screenshots and notes to the README.

Step 18: Create tutorial docs.

Create these files:

tutorial/00_project_overview.md
tutorial/01_environment_setup.md
tutorial/02_dbt_mental_model.md
tutorial/03_building_staging_models.md
tutorial/04_building_intermediate_models.md
tutorial/05_building_marts.md
tutorial/06_dbt_docs_local_ui.md
tutorial/07_dbt_cloud_bigquery.md

Write them for a smart Senior Data Analyst who is new to modern analytics tooling.

Tone:

- Respectful, not juniorizing.
- Explain mental models clearly.
- Do not over-explain SQL basics.
- Explain Git, terminal, dbt, and dbt Cloud concepts in a practical way.

tutorial/01_environment_setup.md should include the manual Kaggle download workflow:

1. Download the Olist dataset manually from Kaggle.
2. Unzip the downloaded file.
3. Copy CSV files into seeds/.
4. Confirm the CSVs are directly under seeds/.
5. Run dbt seed.

tutorial/06_dbt_docs_local_ui.md should explain:

- dbt docs generate
- dbt docs serve
- what lineage means
- how model docs and tests show up
- why this matters for portfolio review

tutorial/07_dbt_cloud_bigquery.md should explain:

- why we started locally first
- what changes when moving from DuckDB to BigQuery
- what dbt Cloud adds: browser IDE, managed environments, jobs, docs, lineage, and Git integration
- what stays the same: models, refs, tests, marts, metric definitions, and GitHub repo structure
- why this matters for analytics roles at tech companies
- do not implement this phase yet

Step 19: Create dashboard spec files.

Create:

dashboards/executive_overview.md
dashboards/seller_performance.md
dashboards/delivery_reliability.md
dashboards/customer_experience.md

Each file should include:

- Audience
- Business questions
- Metrics
- Suggested charts
- Filters
- Example insights to look for

Dashboard page definitions:

executive_overview.md:
Audience: business leadership or marketplace analytics manager.
Questions:

- Are orders and GMV growing?
- What is the completion/cancellation trend?
- Which time periods show unusual performance?
  Metrics:
- gross orders
- completed orders
- canceled orders
- GMV
- AOV
- active customers
- completion rate
- cancellation rate

seller_performance.md:
Audience: marketplace operations or seller management.
Questions:

- Which sellers drive the most GMV?
- Which sellers have high value but poor customer experience?
- Which sellers may need operational support?
  Metrics:
- seller orders
- seller GMV
- average item price
- total freight
- average review score
- late delivery rate

delivery_reliability.md:
Audience: operations analytics.
Questions:

- How often are orders delivered late?
- How large are delivery delays?
- Are delivery issues getting better or worse over time?
  Metrics:
- delivered orders
- late orders
- late delivery rate
- avg delivery delay days
- avg purchase-to-delivered days

customer_experience.md:
Audience: customer insights or CX team.
Questions:

- How do reviews trend over time?
- Are late deliveries associated with lower review scores?
- Which segments have worse customer experience?
  Metrics:
- review count
- avg review score
- low review count
- low review rate
- late delivery rate

Step 20: Create a strong README.md.

README should include:

- Project title: Ding12 — Commerce Marketplace Analytics with dbt
- Project overview
- Dataset source: Brazilian E-Commerce Public Dataset by Olist
- Dataset slug: olistbr/brazilian-ecommerce
- Manual Kaggle download instructions
- Business questions
- Tech stack
- Repo structure
- dbt model architecture: staging, intermediate, marts
- Key metrics
- How to set up environment
- How to copy profiles.example.yml into ~/.dbt/profiles.yml
- How to place the manually downloaded CSV files into seeds/
- How to run the project locally
- How to generate local dbt docs UI
- Dashboard plan
- Resume bullet examples
- Interview story
- Future Polish: dbt Cloud + BigQuery Version
- Next steps

The README should explicitly say:
The current MVP is local-first using dbt Core and DuckDB.
A future polish version will migrate the project to dbt Cloud with BigQuery.
This is meant to demonstrate a more production-like analytics workflow, not to replace the local MVP.
The cloud phase should not block the portfolio MVP.

Environment setup commands to include in README:
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
mkdir -p ~/.dbt
cp profiles.example.yml ~/.dbt/profiles.yml
dbt debug
dbt seed
dbt build
dbt docs generate
dbt docs serve

Manual data setup commands or notes to include:
Download the Kaggle dataset manually.
Unzip it locally.
Copy the CSV files into seeds/.
Confirm files with:
ls seeds/\*.csv

Also include this interview talking point:
“I first built the project locally with dbt Core and DuckDB to keep it lightweight and reproducible. Then I planned a dbt Cloud + BigQuery polish phase to mirror a more production-like analytics workflow, including GitHub integration, cloud warehouse execution, docs, lineage, and scheduled jobs.”

Step 21: Validate the project if data is available.

First check whether the expected CSV files exist in seeds/.

If the CSV files are missing:

- Do not run dbt seed, dbt run, or dbt build.
- Print a clear message that the project files were created but the user still needs to manually download and place the Kaggle CSVs into seeds/.
- Print the exact missing files.

If the CSV files are present:
Run:
dbt debug
dbt seed
dbt run
dbt test
dbt build
dbt docs generate

If dbt docs serve is safe to run interactively, tell the user how to run:
dbt docs serve

If tests fail because the real dataset has duplicates or unexpected values:

- Do not hide the failure.
- Fix the test if the assumption was wrong.
- Add a short README note explaining what the test taught us about the dataset.
- Keep the MVP practical.

Step 22: Commit changes.

Run:
git add .
git commit -m "Initialize Ding12 marketplace analytics dbt project"

Do not push unless I explicitly ask.

Step 23: At the end, output a concise summary:

- What files were created
- Whether the expected Kaggle CSV files were found in seeds/
- Which dataset files are missing, if any
- Whether dbt commands were run
- Whether dbt commands passed
- Whether dbt docs were generated
- Any tests that failed and why
- Any assumptions made
- Next recommended step

Important implementation notes:

- Keep SQL readable.
- Do not over-engineer.
- Do not add unnecessary packages.
- Do not add CI/CD yet.
- Do not implement dbt Cloud yet.
- Do not make BigQuery required for MVP.
- Do not use Kaggle API for now.
- Do not model geolocation unless trivial.
- Prioritize a working end-to-end portfolio over perfect architecture.
- This project should be something a Senior Data Analyst can confidently explain in interviews.
