#!/bin/bash
# AdGuard Filter List - Exact Commands for Publishing

echo "╔═════════════════════════════════════════════════════════════╗"
echo "║  AdGuard DNS Filter List - Publish to GitHub Gist          ║"
echo "║  Complete Command Reference                                ║"
echo "╚═════════════════════════════════════════════════════════════╝"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 PREREQUISITES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✓ GitHub Account: https://github.com/signup"
echo "✓ Git installed: https://git-scm.com/downloads"
echo "✓ GitHub CLI (optional): https://cli.github.com/"
echo ""
echo "Configure Git (one-time):"
echo ""
cat << 'EOF'
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
EOF
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 METHOD 1: GitHub CLI (Fastest - Recommended)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Step 1: Install GitHub CLI"
cat << 'EOF'
# Windows (using winget)
winget install GitHub.cli

# Or download from https://cli.github.com/
EOF
echo ""
echo "Step 2: Authenticate"
cat << 'EOF'
gh auth login
# Follow the prompts to authenticate
EOF
echo ""
echo "Step 3: Navigate to filter directory"
cat << 'EOF'
cd c:\Users\darth\Documents\scripts\gist
EOF
echo ""
echo "Step 4: Create the Gist (ONE COMMAND)"
cat << 'EOF'
gh gist create filterlist.txt --public --description "AdGuard DNS Filter List"
EOF
echo ""
echo "✨ Done! Your Gist URL will be displayed immediately."
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📁 METHOD 2: Git + Web Interface (Traditional)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Step 1: Create Gist on GitHub.com"
echo "  1. Go to: https://gist.github.com/"
echo "  2. Click 'Create a new gist'"
echo "  3. Filename: filterlist.txt"
echo "  4. Paste your filter content"
echo "  5. Description: 'AdGuard DNS Filter List'"
echo "  6. Choose 'Public'"
echo "  7. Click 'Create public gist'"
echo "  8. Copy the SSH URL (git@gist.github.com:XXXXX.git)"
echo ""
echo "Step 2: Clone and setup locally"
cat << 'EOF'
cd c:\Users\darth\Documents\scripts\gist
git init
git config user.name "Your Name"
git config user.email "your@email.com"
git add filterlist.txt AdGuard-FilterList.md README.md
git commit -m "Initial AdGuard filter list"
git remote add origin git@gist.github.com:YOUR_GIST_ID.git
git branch -M main
git push -u origin main
EOF
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📡 Verify Your Gist"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "View your Gist:"
echo "  https://gist.github.com/YOUR_USERNAME/YOUR_GIST_ID"
echo ""
echo "Raw content URL (for AdGuard):"
echo "  https://gist.githubusercontent.com/YOUR_USERNAME/YOUR_GIST_ID/raw"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📥 Import into AdGuard Home"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Option 1: From Gist URL (Recommended)"
echo "  1. AdGuard Home → Filters → DNS blocklists"
echo "  2. Click 'Add blocklist'"
echo "  3. Paste: https://gist.githubusercontent.com/YOUR_USERNAME/YOUR_GIST_ID/raw"
echo "  4. Click 'Add'"
echo ""
echo "Option 2: Manual import"
echo "  1. Copy filterlist.txt content"
echo "  2. AdGuard Home → Filters → Custom filtering rules"
echo "  3. Paste the rules"
echo "  4. Click 'Save'"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔄 Update Your Gist"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "With GitHub CLI:"
cat << 'EOF'
gh gist edit YOUR_GIST_ID -f filterlist.txt
EOF
echo ""
echo "With Git:"
cat << 'EOF'
cd c:\Users\darth\Documents\scripts\gist
# Edit filterlist.txt
git add filterlist.txt
git commit -m "Update filter rules"
git push
EOF
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Filter List Information"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Total Rules: 147+"
echo "Blocking Rules: ~100"
echo "Whitelist Rules: ~47"
echo "Format: AdGuard DNS (Adblock-style syntax)"
echo "Status: ✅ Validated & Duplicate-free"
echo ""
echo "Coverage:"
echo "  ✓ Apple tracking & analytics"
echo "  ✓ Spotify advertising"
echo "  ✓ Paramount+ ad networks"
echo "  ✓ Disney+ blocking"
echo "  ✓ General privacy-invasive domains"
echo "  ✓ Curated whitelist"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎯 Quick Copy-Paste Workflow"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
cat << 'EOF'
# Windows PowerShell / Git Bash

cd c:\Users\darth\Documents\scripts\gist

# One-liner with GitHub CLI (if installed)
gh gist create filterlist.txt --public --description "AdGuard DNS Filter List"

# OR traditional git method
git init
git config user.name "Your Name"
git config user.email "your@email.com"
git add filterlist.txt AdGuard-FilterList.md README.md
git commit -m "AdGuard DNS filter list"

# Then create Gist on https://gist.github.com/ and:
git remote add origin git@gist.github.com:YOUR_GIST_ID.git
git push -u origin main
EOF
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ That's it! Your filter list is now public and ready to use."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📚 Need help?"
echo "  GitHub Gists: https://docs.github.com/en/get-started/writing-on-github/editing-and-sharing-content-with-gists"
echo "  AdGuard Home: https://adguard.com/adguard-home/overview.html"
echo "  DNS Syntax: https://adguard-dns.io/kb/general/dns-filtering-syntax/"
echo ""
