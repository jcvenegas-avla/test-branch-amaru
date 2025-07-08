#!/bin/sh

# 🔐 Ramas protegidas (no permitir push directo)
protected_branches="main|release|develop|develop-cl|develop-pe|develop-mx|develop-us|develop-br"

# ✅ Patrón de nombre de ramas permitidas
valid_branch_pattern='^(feature|hotfix|bugfix|develop-cl|develop-pe|develop-mx|develop-us|develop-br|develop)/(cl|pe|mx|us|br)/[A-Z0-9._-]+$'

while read local_ref local_sha remote_ref remote_sha
do
  branch=$(echo "$remote_ref" | sed 's|refs/heads/||')

  # ❌ 1. Bloquear push directo a ramas protegidas
  if echo "$branch" | grep -Eq "^($protected_branches)$"; then
    echo "❌ Prohibido hacer push directo a '$branch'. Usa Pull Request."
    exit 1
  fi

  # ❌ 2. Validar que el nombre de la rama cumpla el patrón
  if ! echo "$branch" | grep -Eq "$valid_branch_pattern"; then
    echo "❌ Nombre de rama inválido: '$branch'"
    echo "   Debe cumplir con el patrón: tipo/país/NOMBRE"
    echo "   Ejemplo válido: feature/cl/USUARIO-AA-0"
    exit 1
  fi

done

echo "✅ Push permitido: nombre de rama válido y no protegida."
