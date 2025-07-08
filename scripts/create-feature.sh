#!/bin/sh

echo ""
echo "🌎 Selecciona la rama base para crear la feature:"
echo "1) develop-pe"
echo "2) develop-cl"
echo "3) develop-us"
echo "4) develop-br"
echo "5) develop-mx"
echo "6) Salir"
echo ""

printf "Elige una opción (1-6): "
read opcion

case "$opcion" in
  1) BASE_BRANCH="develop-pe"; COUNTRY="pe" ;;
  2) BASE_BRANCH="develop-cl"; COUNTRY="cl" ;;
  3) BASE_BRANCH="develop-us"; COUNTRY="us" ;;
  4) BASE_BRANCH="develop-br"; COUNTRY="br" ;;
  5) BASE_BRANCH="develop-mx"; COUNTRY="mx" ;;
  6) echo "👋 Cancelado."; exit 0 ;;
  *) echo "❌ Opción inválida."; exit 1 ;;
esac

# Solicitar nombre de la feature
echo ""
printf "✏️  Ingresa el nombre de la feature (ej: USUARIO-AA-0): "
read FEATURE_NAME

# Validación básica
if [ -z "$FEATURE_NAME" ]; then
  echo "❌ El nombre no puede estar vacío."
  exit 1
fi

# Formar el nombre completo de la rama
FEATURE_BRANCH="feature/$COUNTRY/$FEATURE_NAME"

# Cambiar a la rama base y actualizarla
echo ""
echo "📥 Cambiando a '$BASE_BRANCH' y actualizando..."
git checkout $BASE_BRANCH || exit 1
git pull origin $BASE_BRANCH || exit 1

# Crear la nueva rama
echo "🌱 Creando nueva rama '$FEATURE_BRANCH' desde '$BASE_BRANCH'..."
git checkout -b "$FEATURE_BRANCH" || exit 1

echo "✅ Rama creada con éxito: $FEATURE_BRANCH"
