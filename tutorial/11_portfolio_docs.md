# 11 — Writing the Portfolio Docs

You've built a tested, documented, deployed project. This short chapter is what
turns that build into a **portfolio** — the `docs/` files that let a reviewer (or
you, in an interview) understand and talk about it in minutes.

> ✍️ **Write these yourself.** They're prose, not code, and they're where *your*
> judgment and business framing show. Use the [reference `docs/`](https://github.com/Skylinnnnnn/ding12/tree/main/docs)
> as a model for structure, but write them in your own words about the choices
> *you* made — that's exactly what you'll say out loud in an interview.

Why this matters: two candidates can build the same marts. The one who can
**explain the metrics, defend the assumptions, and tell the story** is the one who
gets hired. These files are that difference, written down.

---

## The four core docs (write these)

### 1. `docs/metrics_glossary.md` — what every number means
A table of each metric and its exact definition (ideally the formula). Write it
straight from your SQL so the doc and the marts can't drift.

- **Why it matters:** it proves you define metrics precisely — the #1 way analysts
  lose trust is two dashboards showing different "GMV." A glossary is how teams
  agree on one definition.
- **Include:** gross/completed/canceled orders, completion & cancellation rate,
  GMV, freight, AOV, late-delivery flag & rate, delivery delay days, review score,
  low-review rate, active customers.
- **Tip:** note the divide-by-zero handling (`safe_divide` → `nullif`) so a
  reviewer sees you thought about edge cases.

### 2. `docs/business_assumptions.md` — the judgment calls
Every real analysis makes choices. This file lists yours and *defends* them.

- **Why it matters:** senior analysts are judged on assumptions, not SQL. Writing
  "GMV = item price + freight, **not** payment value, because payments include
  installment/voucher noise" shows exactly the reasoning an interviewer wants.
- **Include your calls on:** GMV definition, "low review = score ≤ 2", late metrics
  only counting delivered orders, the reporting-date grain, the review grain
  (one row per review), and the `'unknown'` category bucket for the ~610
  category-less products.
- **Best subsection: "What the tests taught us about the data."** Olist has
  non-unique `order_id`s and category-less products — you *discovered* these via
  failing tests and adjusted the model, not the data. That narrative is gold.

### 3. `docs/interview_story.md` — how you talk about it
Your script for presenting the project, at three lengths.

- **Why it matters:** you'll reuse this in every interview. Writing it now means
  you're rehearsed, not improvising.
- **Include:** a **60-second pitch**, a **3-minute deep dive** (problem framing →
  architecture → data quality → a business insight → visualization/deploy), and
  short **"why dbt / why DuckDB / why Evidence"** answers. End with **"what I'd
  improve next"** (snapshots, incremental models, a retention view, the cloud
  version) — it signals you know the project's edges.
- **Anchor on one real insight:** joining seller GMV to review score and
  late-delivery rate to surface *high-value-but-risky* sellers. A concrete insight
  beats reciting features.

### 4. `docs/resume_bullets.md` — role-tailored bullets
Ready-to-paste bullets grouped by the roles you're targeting.

- **Why it matters:** the same project reads differently to a BI Analyst vs. an
  Analytics Engineer. Pre-writing variants means you tailor a resume in seconds.
- **Include groups for:** Business/Data Analyst, BI Analyst/BIE, Analytics
  Engineer, and Marketplace/Operations Analytics. Lead each bullet with an action
  and a number (~100k orders, six marts, N tests).

---

## Also in `docs/` (already written / future-facing)
- **`docs/cloud_migration_plan.md`** and **`docs/next_steps.md`** — the roadmap for
  the [chapter 12](12_dbt_cloud_bigquery.md) cloud phase. Read them; you don't have
  to build that yet.
- **`docs/demo_runbook.md`** — a script for demoing the project live. Handy when
  you walk someone through it.

## How to work through this chapter
1. Open your marts and your `schema.yml` files next to a blank
   `docs/metrics_glossary.md`, and define each metric from the SQL.
2. Write `business_assumptions.md` by asking, for each metric, *"what did I decide,
   and why?"*
3. Draft `interview_story.md` and read the 60-second pitch **out loud** — if it
   doesn't flow, simplify it.
4. Write `resume_bullets.md` last, pulling numbers from the glossary.
5. Commit: `git add -A && git commit -m "Add portfolio docs" && git push`.

Then tick off **section 8** of the [build checklist](CHECKLIST.md) — and you have a
project you can *build, run, and talk about*.

➡️ Next (optional): [`12_dbt_cloud_bigquery.md`](12_dbt_cloud_bigquery.md) — the
production-like cloud path, and [`../docs/next_steps.md`](../docs/next_steps.md)
for the full roadmap after the tutorial.
