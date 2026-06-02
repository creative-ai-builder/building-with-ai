#!/usr/bin/env bash
# Deploy the site to GitHub Pages (creative-ai-builder/building-with-ai).
#
# Usage: ./deploy.sh "commit message"
#        ./deploy.sh            # uses a default commit message
#
# The repo is owned by the `creative-ai-builder` GitHub account, which differs
# from the default local account. This script switches the active `gh` account
# to push, then switches back to whatever was active before.

set -euo pipefail

PUSH_ACCOUNT="creative-ai-builder"
BRANCH="master"
MSG="${1:-Update site}"

cd "$(dirname "$0")"

# Remember the currently active gh account so we can restore it afterward.
ORIGINAL_ACCOUNT="$(gh api user --jq .login 2>/dev/null || true)"

restore_account() {
  if [ -n "$ORIGINAL_ACCOUNT" ] && [ "$ORIGINAL_ACCOUNT" != "$PUSH_ACCOUNT" ]; then
    gh auth switch --user "$ORIGINAL_ACCOUNT" >/dev/null 2>&1 || true
  fi
}
trap restore_account EXIT

# Stage and commit any changes (skip the commit if there's nothing to commit).
git add -A
if ! git diff --cached --quiet; then
  git commit -m "$MSG"
else
  echo "No changes to commit; pushing existing commits."
fi

# Switch to the account that has write access and push.
gh auth switch --user "$PUSH_ACCOUNT" >/dev/null
gh auth setup-git >/dev/null 2>&1 || true
git push origin "$BRANCH"

echo "Deployed. Live at https://creative-ai-builder.github.io/building-with-ai/ (rebuild ~1-2 min)."
