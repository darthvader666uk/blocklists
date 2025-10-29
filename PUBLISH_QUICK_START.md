# Quick Start: Publish Your AdGuard Filter List to GitHub Gist

## Prerequisites

- GitHub account (create at https://github.com)
- Git installed (https://git-scm.com/downloads)
- GitHub CLI (optional but recommended): https://cli.github.com/

## Fastest Method (Using GitHub CLI)

### 1. Install GitHub CLI
```bash
# Windows (using winget or choco)
winget install GitHub.cli

# Or download from: https://cli.github.com/
```

### 2. Authenticate with GitHub
```bash
gh auth login
# Follow the prompts to authenticate
```

### 3. Create the Gist
Navigate to your filterlist directory and run:

```bash
cd c:\Users\darth\Documents\scripts\gist

# Create public Gist from filterlist.txt
gh gist create filterlist.txt --public --description "AdGuard DNS Filter List"
```

The command will output your Gist URL like:
```
https://gist.github.com/YOUR_USERNAME/a1b2c3d4e5f6g7h8
```

### 4. Access Your Filter List

**View Gist:**
```
https://gist.github.com/YOUR_USERNAME/YOUR_GIST_ID
```

**Raw content URL (use this in AdGuard):**
```
https://gist.githubusercontent.com/YOUR_USERNAME/YOUR_GIST_ID/raw
```

---

## Alternative Method (Using Git + Web UI)

### 1. Create Gist on GitHub

1. Go to https://gist.github.com/
2. Click **"Create a new gist"**
3. Add filename: `filterlist.txt`
4. Paste your filter list content
5. Add description: "AdGuard DNS Filter List"
6. Select **"Public"** (or "Private" for personal use)
7. Click **"Create public gist"**

### 2. Get Your Gist URL and Clone It

After creation, copy the Gist SSH URL (e.g., `git@gist.github.com:a1b2c3d4e5f6.git`)

### 3. Clone and Update Locally

```bash
cd ~/github-gists
git clone git@gist.github.com:YOUR_GIST_ID.git adguard-filterlist
cd adguard-filterlist

# Copy your updated filterlist.txt and README
cp /path/to/filterlist.txt .
cp /path/to/AdGuard-FilterList.md README.md

# Commit and push
git add .
git commit -m "Add AdGuard filter list and documentation"
git push
```

---

## Full Git Workflow (Manual Setup)

```bash
# Step 1: Configure Git
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

# Step 2: Create local directory
mkdir -p ~/github-gists/adguard-filterlist
cd ~/github-gists/adguard-filterlist

# Step 3: Initialize Git
git init

# Step 4: Copy your files
cp c:\Users\darth\Documents\scripts\gist\filterlist.txt .
cp c:\Users\darth\Documents\scripts\gist\AdGuard-FilterList.md README.md

# Step 5: Create initial commit
git add .
git commit -m "Initial AdGuard filter list"

# Step 6: Create Gist on GitHub (https://gist.github.com/)
# Then link it:
git remote add origin git@gist.github.com:YOUR_GIST_ID.git
git branch -M main
git push -u origin main
```

---

## Using Your Filter List in AdGuard Home

### Option 1: Import from Gist URL

1. Open **AdGuard Home** → **Filters** → **DNS blocklists**
2. Click **"Add blocklist"**
3. Paste raw URL: `https://gist.githubusercontent.com/YOUR_USERNAME/YOUR_GIST_ID/raw`
4. Click **"Add"**
5. Enable the filter

### Option 2: Manual Import

1. Copy the raw content from your Gist
2. In AdGuard Home → **Filters** → **Custom filtering rules**
3. Paste the rules
4. Click **"Save"**

---

## Updating Your Gist

### With GitHub CLI:
```bash
# Make changes to filterlist.txt
gh gist edit YOUR_GIST_ID -f filterlist.txt
```

### With Git:
```bash
cd ~/github-gists/adguard-filterlist
# Edit filterlist.txt
git add filterlist.txt
git commit -m "Update filter rules"
git push
```

---

## Example: Complete Setup (Copy & Paste)

```bash
# 1. Create directory
mkdir -p ~/github-gists/adguard-filterlist
cd ~/github-gists/adguard-filterlist

# 2. Copy files
cp "c:\Users\darth\Documents\scripts\gist\filterlist.txt" .
cp "c:\Users\darth\Documents\scripts\gist\AdGuard-FilterList.md" README.md

# 3. Create Gist with GitHub CLI (easiest)
gh gist create filterlist.txt --public --description "AdGuard DNS Filter List"

# Done! Your Gist URL will be displayed
```

---

## Troubleshooting

**Git command not found?**
- Install Git from https://git-scm.com/downloads
- Restart your terminal after installation

**GitHub CLI not found?**
- Install from https://cli.github.com/
- Or use the manual Git method instead

**Authentication fails?**
- Run: `gh auth login` (for CLI)
- Or use SSH key for Git (https://docs.github.com/en/authentication/connecting-to-github-with-ssh)

**Changes not appearing?**
- Ensure you've pushed: `git push`
- Wait a moment for GitHub to update
- Refresh your browser

---

## Support

For more info on GitHub Gists:
- https://docs.github.com/en/get-started/writing-on-github/editing-and-sharing-content-with-gists

For AdGuard Home configuration:
- https://adguard.com/adguard-home/overview.html
