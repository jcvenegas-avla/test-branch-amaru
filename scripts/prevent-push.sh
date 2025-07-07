#!/bin/sh

protected_branches="main|release|develop|develop-cl|develop-pe|develop-mx|develop-us|develop-br"

while read local_ref local_sha remote_ref remote_sha
do
  branch=$(echo "$remote_ref" | sed 's|refs/heads/||')
  if echo "$branch" | grep -Eq "^($protected_branches)$"; then
    echo "❌ Prohibido hacer push directo a '$branch'. Usa Pull Request."
    exit 1
  fi
done
