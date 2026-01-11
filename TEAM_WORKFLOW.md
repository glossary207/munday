# Team Collaboration Workflow

Welcome to the **Munday** project! This guide explains how to work together as a team using GitHub.

## 1. Getting Access (For New Team Members)
**Repository URL**: `https://github.com/glossary207/munday`

To edit code, you must be invited as a **Collaborator**:
1. The Owner (glossary207) goes to **Settings** -> **Collaborators** on GitHub.
2. Click **Add people** and enter the team member's username or email.
3. The team member accepts the invite from their email.

---

## 2. Daily Workflow (How to "Downlink" & Update)

To make sure everyone is working on the same version of the project, follow this routine:

### A. Start of the Day: "Downlink" (Get Updates)
Before you start coding, always get the latest code from your team:
```bash
git pull origin main
```
*This downloads the latest changes from GitHub to your computer.*

### B. Make Changes
Edit your files, fix bugs, or add features in VS Code / FlutterFlow as usual.

### C. Save & Upload: "Uplink" (Share Updates)
When you are done with a task:
1. **Stage your changes** (Prepare them):
   ```bash
   git add .
   ```
2. **Commit your changes** (Save them with a message):
   ```bash
   git commit -m "Describe what you did (e.g. Fixed login bug)"
   ```
3. **Push to GitHub** (Upload):
   ```bash
   git push origin main
   ```

---

## 3. Resolving Conflicts
If `git pull` fails because someone else edited the same line of code as you:
1. Git will tell you which files have "CONFLICTS".
2. Open those files in VS Code.
3. Look for markers like `<<<<<<< HEAD` (your code) and `>>>>>>>` (incoming code).
4. Delete the markers and keep the code you actually want.
5. Save the file.
6. Run:
   ```bash
   git add .
   git commit -m "Fixed merge conflict"
   git push origin main
   ```

## 4. Cheat Sheet
| Command | What it does |
| :--- | :--- |
| `git status` | Checks what files you have changed. |
| `git pull` | Downloads updates (Syncs **down**). |
| `git push` | Uploads your changes (Syncs **up**). |
| `git log` | Shows history of who did what. |
