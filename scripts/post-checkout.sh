#!/bin/sh

branch=$(git rev-parse --abbrev-ref HEAD)

if [ "$branch" = "main" ] || [ "$branch" = "release" ] || [ "$branch" = "develop" ] || [ "$branch" = "develop-cl" ] || [ "$branch" = "develop-pe" ] || [ "$branch" = "develop-mx" ] || [ "$branch" = "develop-us" ] || [ "$branch" = "develop-br" ]; then
  echo "⚠️  Estás en '$branch'. No desarrolles directamente aquí."
fi
