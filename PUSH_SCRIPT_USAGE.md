# 🚀 Auto Push to Gist - Usage Guide

## What This Does

These scripts automatically commit and push your changes to your GitHub Gist. No more manual git commands needed!

---

## 📦 Files Created

1. **`push-to-gist.sh`** - For bash/Git Bash (Linux, macOS, Windows Git Bash)
2. **`push-to-gist.bat`** - For Windows Command Prompt (easiest on Windows)

---

## 🎯 How to Use

### Option 1: Windows Command Prompt (Easiest)

```bash
# Navigate to your gist directory
cd c:\Users\darth\Documents\scripts\gist

# Run the script
push-to-gist.bat
```

**Or with custom commit message:**
```bash
push-to-gist.bat "Add new blocking rules for Spotify"
```

---

### Option 2: Git Bash / Bash Shell

```bash
# Navigate to your gist directory
cd c:\Users\darth\Documents\scripts\gist

# Run the script
bash push-to-gist.sh
```

**Or with custom commit message:**
```bash
bash push-to-gist.sh "Add new blocking rules for Spotify"
```

---

## 📋 What Happens When You Run It

1. ✅ Checks if you're in a git repository
2. ✅ Detects any changes to your files
3. ✅ Shows you what changed
4. ✅ Stages all changes (`git add -A`)
5. ✅ Creates a commit with your message
6. ✅ Pushes to your Gist
7. ✅ Shows recent commits
8. ✅ Displays your Gist URLs

---

## 💡 Common Workflows

### Workflow 1: Edit filterlist.txt and Push

```bash
# 1. Edit filterlist.txt in your editor
#    (make your changes)

# 2. Run the push script
cd c:\Users\darth\Documents\scripts\gist
push-to-gist.bat "Updated blocking rules"

# Done! Changes are live on your Gist
```

### Workflow 2: Quick Push with Default Message

```bash
cd c:\Users\darth\Documents\scripts\gist
push-to-gist.bat

# Uses default message: "Update filter rules - YYYY-MM-DD HH:MM:SS"
```

### Workflow 3: Multiple File Updates

```bash
# 1. Edit filterlist.txt
# 2. Edit README.md
# 3. Edit any other files

# 4. Push everything at once
cd c:\Users\darth\Documents\scripts\gist
push-to-gist.bat "Update rules and documentation"

# All changes pushed together in one commit
```

---

## 🔍 Example Output

```
========================================
 AdGuard Filter List - Auto Push
========================================

Changes detected:

 M filterlist.txt

Staging changes...
Files staged

Creating commit...
Message: Updated blocking rules - 2025-10-29 14:30:45
[main abc1234] Updated blocking rules - 2025-10-29 14:30:45
 1 file changed, 5 insertions(+)

Pushing to Gist...
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression: 100% (3/3), done.
Writing objects: 100% (3/3), 1.23 KiB, done.
Total 3 (delta 2), reused 0 (delta 0)
remote: Resolving deltas: 100% (2/2), done.
To https://gist.github.com/ccfdab18b9d59830876c373db8b4210d.git
   abc1234..def5678  main -> main
Successfully pushed to Gist

========================================
 Push Complete!
========================================

Gist Information:
   View:    https://gist.github.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d
   Raw URL: https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw

Recent commits:
def5678 Updated blocking rules - 2025-10-29 14:30:45
abc1234 Initial commit
1a2b3c4 Merge changes

Done!
```

---

## ⚡ Quick Reference

| Task | Command |
|------|---------|
| **Push with default message** | `push-to-gist.bat` |
| **Push with custom message** | `push-to-gist.bat "Your message"` |
| **Using bash** | `bash push-to-gist.sh "Your message"` |
| **No changes** | Script exits safely (no error) |

---

## 🔧 Troubleshooting

### "Not in a git repository"
- Make sure you're in: `c:\Users\darth\Documents\scripts\gist`
- Run: `cd c:\Users\darth\Documents\scripts\gist`

### "Permission denied"
- Right-click command prompt and run as Administrator
- Or use Git Bash instead

### "Git command not found"
- Install Git from: https://git-scm.com/downloads
- Restart your terminal

### "Nothing to commit"
- You haven't made any changes to your files yet
- Edit `filterlist.txt` or other files first

---

## 📌 Set Up as Quick Launch

### Windows: Create Shortcut

1. Right-click `push-to-gist.bat`
2. Create shortcut
3. Edit shortcut target to: `cmd /k cd c:\Users\darth\Documents\scripts\gist && push-to-gist.bat`
4. Now you can double-click the shortcut to push

### Bash: Create Alias

Add to your `.bashrc`:
```bash
alias push-gist='cd c:\Users\darth\Documents\scripts\gist && bash push-to-gist.sh'
```

Then just run: `push-gist "your message"`

---

## 🎯 Your Gist

**Gist URL:** https://gist.github.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d  
**Raw URL:** https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw

---

## ✅ You're All Set!

Just edit your files and run the script to push. That's it! 🚀
