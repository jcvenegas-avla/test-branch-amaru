#!/bin/bash
# JCVENEGAS-2
echo "🔧 Instalando Git hooks..."

cp scripts/hooks/commit-msg.sh .git/hooks/commit-msg
cp scripts/hooks/pre-push.sh .git/hooks/pre-push
cp scripts/hooks/post-checkout.sh .git/hooks/post-checkout
cp scripts/hooks/pre-commit.sh .git/hooks/pre-commit

chmod +x .git/hooks/*

echo "✅ Hooks instalados correctamente."

# sh install-hooks.sh
# JCVENEGAS-1