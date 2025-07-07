#!/bin/sh

MSG_FILE=$1
MSG=$(cat "$MSG_FILE")

PATTERN="^(CHG|ADD|FIX|DEL|GIT): (HU|DT|E|PP): (MP|CL|PE|MX|BR|US): (SPDI|CDA|AMARUCH|AUT|PA|AB)-[0-9]{1,}. .{1,}$"

if ! echo "$MSG" | grep -Eq "$PATTERN"; then
  echo "❌ Commit inválido."
  echo "$MSG" >&2
  echo "" >&2
  echo "Abortando commit. Su mensaje de commit no es válido." >&2
  echo "El formato debe ser: <Tipo>: <Tipo de cambio>: <Pais>: <Código de Jira>. <Descripción>" >&2
  echo "<Tipo> debe ser: CHG, ADD, FIX, DEL, GIT" >&2
  echo "<Tipo de cambio> debe ser: HU, DT, E, PP" >&2
  echo "<Pais> debe ser: Código iso del país o MP para todos los países CL" >&2
  echo "Ej: CHG: DT: CL: AUT-999. Columna nueva en entidad Sale" >&2
  exit 1
fi
