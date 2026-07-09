# 00b — GitHub & Git Setup (build your own repo)

This chapter gets you from *nothing* to *an empty project on GitHub that you own*.
You'll build **your own** Ding12 into this repo, chapter by chapter — you are not
cloning someone else's. Use the reference repo only to check your work:

> **Reference / answer key:** https://github.com/Skylinnnnnn/ding12

> **Which terminal for this chapter:** your project folder and VS Code setup don't
> exist yet, so run these steps in a **standalone terminal** — on Windows open
> **PowerShell** (Start menu → type "PowerShell"), on macOS open **Terminal**.
> Once you've created the `ding12` folder (step 5), you can open it in VS Code and,
> from chapter `01` onward, do everything in VS Code's built-in terminal instead.

## 1. Create a GitHub account
Go to https://github.com and sign up (free). Pick a username you're happy to show
on a resume — this becomes part of your project URL.

## 2. Install the tools
**Git** (version control) and the **GitHub CLI** (`gh`, the easiest way to log in):

- **Windows (PowerShell):**
  ```powershell
  winget install Git.Git
  winget install GitHub.cli
  ```
- **macOS:**
  ```bash
  brew install git gh
  ```
Check they're installed:
```bash
git --version
gh --version
```

## 3. Tell Git who you are
Use the **private no-reply email** GitHub gives you (Settings → Emails → "Keep my
email addresses private") so your real email never lands in commit history:
```bash
git config --global user.name "Your Name"
git config --global user.email "your-id+username@users.noreply.github.com"
```

## 4. Log in to GitHub from the terminal
```bash
gh auth login
```
Choose **GitHub.com → HTTPS → Yes (authenticate Git) → Login with a web browser**,
and approve in the browser. This also configures Git to push over HTTPS.

## 5. Create your project folder and the empty repo
```bash
# make the folder and go into it
mkdir ding12
cd ding12

# start version control here
git init

# create the (empty) GitHub repo AND link it as 'origin', all in one command
gh repo create ding12 --public --source=. --remote=origin
```
> `--source=.` links the repo you just `git init`ed; `--public` makes it visible
> for your portfolio (use `--private` if you'd rather keep it hidden for now).

## 6. Make your first commit and push
Create a placeholder so there's something to commit, then push:
```bash
# a starter README (you'll flesh it out later)
echo "# Ding12 — Commerce Marketplace Analytics" > README.md

git add README.md
git commit -m "Initial commit"
git branch -M main          # name the default branch 'main'
git push -u origin main
```
Refresh your repo page on GitHub — your README is live. 🎉

> **Where did it go?** Your files live on *your computer*; `git push` copied them
> up to GitHub. That local-vs-cloud split is the thing to get straight early —
> see [`00c_how_it_all_fits.md`](00c_how_it_all_fits.md) for the picture.

## 7. Create the folder skeleton
You'll fill these in over the next chapters:
```bash
# macOS / Linux
mkdir -p seeds models/staging models/intermediate models/marts \
         macros tests analyses dashboards docs tutorial scripts
```
```powershell
# Windows (PowerShell)
mkdir seeds, models\staging, models\intermediate, models\marts, `
      macros, tests, analyses, dashboards, docs, tutorial, scripts
```

## The rhythm from here on
Each build chapter follows the same loop:
1. **Create/edit files** (write the ones marked ✍️, copy the ones marked 📋).
2. **Run something** (`dbt build`, `npm run dev`, …) to see it work.
3. **Commit**: `git add -A && git commit -m "…"` and `git push`.

Committing often is a habit worth building now — small commits with clear
messages are exactly what reviewers and teammates want to see.

➡️ Next: [`01_environment_setup.md`](01_environment_setup.md).
