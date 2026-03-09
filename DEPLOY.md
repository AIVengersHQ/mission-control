# Deploy Instructions — AIVengers Mission Control Dashboard

The git repo is **already initialized and committed** locally. 
You just need to push it to GitHub.

## Option A: Using GitHub CLI (gh)

```bash
# 1. Authenticate gh CLI (need a GitHub token)
gh auth login

# 2. Create the repo
gh repo create AIVengersHQ/mission-control --public --description "AIVengers Mission Control Dashboard"

# 3. Push
cd /Users/aivengers/.openclaw/workspace-sage/dashboard
git remote add origin https://github.com/AIVengersHQ/mission-control.git
git push -u origin main

# 4. Enable GitHub Pages
gh api repos/AIVengersHQ/mission-control/pages \
  -X POST \
  -f source[branch]=main \
  -f source[path]=/

# Dashboard will be live at:
# https://aivengershq.github.io/mission-control/
```

## Option B: Manual via GitHub.com

1. Go to https://github.com/new
2. Owner: **AIVengersHQ**, Repo name: **mission-control**
3. Set to **Public**, no README
4. Click **Create repository**
5. Run in Terminal:
```bash
cd /Users/aivengers/.openclaw/workspace-sage/dashboard
git remote add origin https://github.com/AIVengersHQ/mission-control.git
git push -u origin main
```
6. Go to repo Settings → Pages → Source: **main branch / root**
7. Live at: **https://aivengershq.github.io/mission-control/**

---

*Local repo is ready at: `/Users/aivengers/.openclaw/workspace-sage/dashboard/`*
*Commits: 2 (dashboard + index redirect)*
