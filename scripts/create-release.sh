#!/bin/bash

# ---------------------------
# Script para crear una release branch desde develop
# y hacer merge de múltiples ramas
# ---------------------------

set -e  # salir ante cualquier error

echo "🛠 Crear nueva rama Release desde develop"

# Inputs
read -p "🌍 Ingrese el código de países (ej: pe | cl | mx | us  | br): " COUNTRY_CODES
read -p "📦 Ingrese el nombre de la release (ej: 1.0.1): " RELEASE_NAME
read -p "🌿 Ingrese las ramas a mergear (separadas por coma): " BRANCHES

RELEASE_BRANCH="Release/${COUNTRY_CODES}/${RELEASE_NAME}"

echo "🚀 Creando rama $RELEASE_BRANCH desde develop..."

# Asegurar que estamos actualizados
git checkout develop
git pull origin develop

# Crear la nueva rama release
git checkout -b "$RELEASE_BRANCH"

# Separar ramas por coma y recorrer
IFS=',' read -ra BRANCH_ARRAY <<< "$BRANCHES"
for branch in "${BRANCH_ARRAY[@]}"; do
  TRIMMED_BRANCH=$(echo "$branch" | xargs)  # quita espacios alrededor
  echo "🔀 Haciendo merge de '$TRIMMED_BRANCH'..."
  git fetch origin "$TRIMMED_BRANCH"
  git merge origin/"$TRIMMED_BRANCH" --no-edit || {
    echo "❌ Conflicto al hacer merge con '$TRIMMED_BRANCH'. Revisa manualmente."
    exit 1
  }
done

echo "✅ Branch de release '$RELEASE_BRANCH' creada y merge completado."

# Opcional: preguntar si quiere hacer push
read -p "¿Deseas hacer push a origin? (s/n): " DO_PUSH
if [[ "$DO_PUSH" =~ ^[sS]$ ]]; then
  git push origin "$RELEASE_BRANCH"
  echo "🚀 Branch enviada a remoto: origin/$RELEASE_BRANCH"
fi
