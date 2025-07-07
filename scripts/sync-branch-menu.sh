#!/bin/sh

echo ""
echo "🌎 Selecciona una rama para sincronizar con 'develop':"
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
  1) TARGET_BRANCH="develop-pe" ;;
  2) TARGET_BRANCH="develop-cl" ;;
  3) TARGET_BRANCH="develop-us" ;;
  4) TARGET_BRANCH="develop-br" ;;
  5) TARGET_BRANCH="develop-mx" ;;
  6) echo "👋 Cancelado."; exit 0 ;;
  *) echo "❌ Opción inválida."; exit 1 ;;
esac

echo ""
echo "🔄 Sincronizando '$TARGET_BRANCH' con 'develop'..."

# Cambiar a develop y actualizar
git checkout develop || exit 1
git pull origin develop || exit 1

# Eliminar rama local si ya existe
if git show-ref --quiet refs/heads/$TARGET_BRANCH; then
  git branch -D $TARGET_BRANCH
fi

# Crear rama desde develop
git checkout -b $TARGET_BRANCH || exit 1
git push -f origin $TARGET_BRANCH || exit 1

echo "✅ '$TARGET_BRANCH' ahora es igual a 'develop'"
