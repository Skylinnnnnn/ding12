# Demo Runbook (local)

A script for demoing Ding12 live. The order is deliberate: **show the finished
result first (the public URL — zero friction), then prove it's reproducible, then
show it's learnable.** That sequence is what convinces someone "I can do this too."

Commands are macOS. **Golden rule:** only one process can open `ding12.duckdb` at
a time — finish the `dbt` steps before starting the DuckDB UI or Evidence, and
don't run two readers at once. If anything local hiccups, the live URL alone
carries the whole demo.

## ⏱️ Before the demo (5-min prep, do it alone)
```bash
cd /Users/huahuamac/Desktop/Ding12/ding12
source .venv/bin/activate

# 1. Confirm a clean green build (warms the DuckDB file too)
dbt build            # expect: PASS=74 ... ERROR=0

# 2. Pre-generate docs so `dbt docs serve` is instant during the demo
dbt docs generate

# 3. Pre-materialize the dashboard data so `npm run dev` starts fast
cd reports && npm run sources && cd ..
```
Open these browser tabs ahead of time:
- Live dashboard: https://skylinnnnnn.github.io/ding12/
- GitHub repo: https://github.com/Skylinnnnnn/ding12

(Start `localhost:8080`, `localhost:4213`, `localhost:3000` later, during the demo.)

## 🎬 The demo (~12 min)

**1. 30-second pitch + the payoff.** Open https://skylinnnnnn.github.io/ding12/
and click through the 5 pages.
> "This turns raw public e-commerce data into a tested, documented, live
> dashboard — built with the exact tools modern data teams use. It auto-updates
> from GitHub."

**2. It's real, version-controlled code.** Show the GitHub repo: folder structure,
README, commit history + green Actions checks.
> "Every push rebuilds and redeploys the dashboard automatically."

**3. It's reproducible — data quality is enforced.**
```bash
dbt build
```
Point at **`PASS=74 ... ERROR=0`.**
> "74 automated tests — uniqueness, referential integrity, valid values. This is
> how you *trust* the numbers."

**4. See how it all connects (lineage).**
```bash
dbt docs serve      # http://localhost:8080 — Ctrl+C when done
```
Click a mart → trace the DAG back to the raw seeds.

**5. Real analysis, live, from a SQL cell.** Stop docs (Ctrl+C), then:
```bash
python scripts/open_ui.py    # http://localhost:4213 — Ctrl+C when done
```
Run the sample query, switch to **chart view**, and tell the story:
> "March 2018 spikes to a 21.4% late-delivery rate — an anomaly worth
> investigating. And delays are usually negative, meaning Olist delivers *ahead*
> of its estimates."

**6. The dashboard runs locally too.** Stop the UI (Ctrl+C), then:
```bash
cd reports && npm run dev    # http://localhost:3000 — Ctrl+C when done
```
> "Same marts, now interactive. Edit a page, the browser updates live."

**7. The clincher — she can build this herself.** Open
[`../tutorial/CHECKLIST.md`](../tutorial/CHECKLIST.md) and one build chapter (e.g.
`05`).
> "Step-by-step, build-your-own-repo guide. ✍️ = write it yourself (official dbt
> docs linked right there); 📋 = copy the boilerplate. You build into your own
> repo and check against mine as the answer key — Windows-friendly, start to
> finish."

## 🗣️ Talking points that convince her
- **"You already have the hard part."** Her SQL + business sense is 80% of it; the
  tutorial adds the tooling wrapper (Git, dbt, docs, deploy).
- **"Nothing here is magic or expensive."** Runs free on a laptop — no cloud
  account, no Kaggle API, no secrets.
- **"This is a portfolio piece with a live URL"** she can put on a resume tomorrow.
- **"Every mistake is documented"** (e.g. the `'unknown'`-category test finding and
  the deploy `npm run sources` bug) — real analytics-engineering lessons.

## ⚠️ Don'ts during the demo
- Don't run `dbt build` while the DuckDB UI or Evidence is open (file lock) —
  Ctrl+C the reader first.
- Each server holds its terminal; use a **second terminal tab** (also
  `source .venv/bin/activate`) if you want dbt + a server side-by-side.
- Ports: docs `8080`, DuckDB UI `4213`, Evidence `3000` — no conflicts; stop each
  with Ctrl+C.
