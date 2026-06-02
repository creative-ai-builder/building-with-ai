# Building With AI — Project Notes

Static single-page marketing site for a summer AI camp. The entire site is [index.html](index.html) (HTML + inline CSS/JS). No build step.

## Deployment

- **Hosting:** GitHub Pages, served from `master` of `creative-ai-builder/building-with-ai`.
- **Live URL:** https://creative-ai-builder.github.io/building-with-ai/
- **Flow:** push to `master` → GitHub Pages rebuilds automatically (~1–2 min). There is no separate build/CI step.

### Push access

The repo is owned by the `creative-ai-builder` GitHub account, **not** the default
local account (`nikhiljgeorge`). Pushing requires switching the active `gh` account
first. The `deploy.sh` script handles this automatically.

To deploy: `./deploy.sh "commit message"`

If pushing manually:
```bash
gh auth switch --user creative-ai-builder
git push origin master
gh auth switch --user nikhiljgeorge   # switch back
```
