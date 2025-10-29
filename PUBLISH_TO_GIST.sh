#!/bin/bash
# AdGuard Filter List - GitHub Gist Publishing Guide

echo "=========================================="
echo "GitHub Gist Publishing Instructions"
echo "=========================================="
echo ""
echo "Step 1: Ensure git is configured with your GitHub credentials"
echo "Command: git config --global user.name 'Your Name' && git config --global user.email 'your@email.com'"
echo ""
echo "=========================================="
echo "Step 2: Create a local directory for the Gist"
echo ""

# Create gist directory
mkdir -p ~/github-gists/adguard-filterlist
cd ~/github-gists/adguard-filterlist

echo "Command: mkdir -p ~/github-gists/adguard-filterlist && cd ~/github-gists/adguard-filterlist"
echo ""

echo "=========================================="
echo "Step 3: Initialize git repository"
echo ""
echo "Command: git init"
echo ""

# Initialize git
git init

echo "=========================================="
echo "Step 4: Add your filter list files"
echo ""
echo "Copy these files to ~/github-gists/adguard-filterlist/:"
echo "  - filterlist.txt (your actual DNS rules)"
echo "  - AdGuard-FilterList.md (README/documentation)"
echo ""
echo "Then run: git add ."
echo ""

# Add files (assuming they exist)
git add .

echo "=========================================="
echo "Step 5: Create initial commit"
echo ""
echo "Command: git commit -m 'Initial AdGuard filter list'"
echo ""

# Commit
git commit -m "Initial AdGuard filter list"

echo "=========================================="
echo "Step 6: Add GitHub as remote and push to Gist"
echo ""
echo "NOTE: You have two options:"
echo ""
echo "OPTION A - Using GitHub CLI (Recommended):"
echo "  1. Install GitHub CLI: https://cli.github.com/"
echo "  2. Authenticate: gh auth login"
echo "  3. Create Gist:"
echo "     gh gist create filterlist.txt --public --description 'AdGuard DNS Filter List'"
echo ""
echo "OPTION B - Using git directly (Manual):"
echo "  1. Go to: https://gist.github.com/"
echo "  2. Create new Gist manually"
echo "  3. Copy the Gist SSH URL"
echo "  4. Run:"
echo "     git remote add origin git@gist.github.com:YOUR_GIST_ID.git"
echo "     git branch -M main"
echo "     git push -u origin main"
echo ""

echo "=========================================="
echo "Step 7: Get your Gist URL"
echo ""
echo "After publishing, your Gist will be available at:"
echo "  https://gist.github.com/YOUR_USERNAME/YOUR_GIST_ID"
echo ""
echo "Raw content URL (for AdGuard import):"
echo "  https://gist.githubusercontent.com/YOUR_USERNAME/YOUR_GIST_ID/raw"
echo ""

echo "=========================================="
echo "Step 8: Update existing Gist"
echo ""
echo "To update your Gist later:"
echo "  1. Make changes to your files"
echo "  2. git add ."
echo "  3. git commit -m 'Update filter rules'"
echo "  4. git push"
echo ""

echo "=========================================="
echo "Quick Commands Summary"
echo "=========================================="
echo ""
echo "# Setup (one-time)"
echo "git config --global user.name 'Your Name'"
echo "git config --global user.email 'your@email.com'"
echo "mkdir -p ~/github-gists/adguard-filterlist"
echo "cd ~/github-gists/adguard-filterlist"
echo ""
echo "# Initialize and commit"
echo "git init"
echo "cp /path/to/filterlist.txt ."
echo "cp /path/to/AdGuard-FilterList.md ."
echo "git add ."
echo "git commit -m 'Initial AdGuard filter list'"
echo ""
echo "# Publish with GitHub CLI (easiest)"
echo "gh gist create filterlist.txt --public --description 'AdGuard DNS Filter List'"
echo ""
echo "=========================================="
echo ""
