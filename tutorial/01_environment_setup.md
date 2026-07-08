# 01 — Environment Setup

## 0. Check your Python version first (important)
dbt supports **Python 3.9–3.13**. It does **not** yet run on Python **3.14**, and
`pip install` will fail if that's your default. Check:

```bash
python3 --version
```

- If it says 3.9–3.13, you're good — use `python3` below.
- If it says **3.14** (or you're unsure), install a supported version. On macOS
  with Homebrew:
  ```bash
  brew install python@3.12
  ```
  Then use the full path `/opt/homebrew/opt/python@3.12/bin/python3.12` in place
  of `python3` in the next step (just for creating the venv — once the venv
  exists, `python`/`pip` inside it are already the right version).

## 1. Python virtual environment
A virtual environment keeps this project's packages isolated from the rest of
your machine. From the repo root:

```bash
python3 -m venv .venv          # or the python@3.12 path from step 0
source .venv/bin/activate      # macOS/Linux
pip install --upgrade pip
pip install -r requirements.txt
```

You'll know it worked when your prompt shows `(.venv)` and `dbt --version` runs.

## 2. Point dbt at DuckDB (the profile)
dbt reads connection settings from `~/.dbt/profiles.yml`. We ship a template:

```bash
mkdir -p ~/.dbt
cp profiles.example.yml ~/.dbt/profiles.yml
```

This tells dbt to use DuckDB and to create a local database file
`ding12.duckdb` in the repo. Verify the connection:

```bash
dbt debug
```

All green checks = you're connected.

## 3. Get the data (manual Kaggle download)
We download the dataset **manually** (no Kaggle API for the MVP):

1. Open the dataset page (sign in to Kaggle first — a free account is required):
   https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?resource=download
2. Click **Download** (downloads `archive.zip`).
3. Unzip the downloaded file.
4. Copy **all CSV files** into the `seeds/` folder.
5. Confirm the CSVs sit **directly under `seeds/`**, not inside a nested folder.
6. Then run `dbt seed`.

Confirm the files are in place:

```bash
ls seeds/*.csv
```

You should see the eight modeled files (customers, orders, order_items,
order_payments, order_reviews, products, sellers, product_category translation).
`olist_geolocation_dataset.csv` may also be present; it's fine to leave it — the
MVP doesn't model it.

## 4. Build everything
```bash
dbt seed      # load CSVs into DuckDB
dbt run       # build staging, intermediate, marts
dbt test      # run data-quality tests
dbt build     # (alternative) seed + run + test in dependency order
```

If `dbt seed` can't find the CSVs, revisit step 3 — the files must be directly
under `seeds/`.
