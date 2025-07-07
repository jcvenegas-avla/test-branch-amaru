#!/bin/bash

echo "🔧 Instalando Git hooks..."

cp scripts/validate-commit-msg.sh .git/hooks/commit-msg
cp scripts/prevent-push.sh .git/hooks/pre-push
cp scripts/post-checkout.sh .git/hooks/post-checkout
cp scripts/pre-commit.sh .git/hooks/pre-commit

chmod +x .git/hooks/*

echo "✅ Hooks instalados correctamente."

# sh install-hooks.sh