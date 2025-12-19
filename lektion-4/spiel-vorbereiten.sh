#!/usr/bin/env bash
set -u
ROOT="spiel"
rm -rf "$ROOT"
mkdir -p "$ROOT/berichte"
cat > "$ROOT/berichte/bericht-a.txt" <<'EOF'
Heute war Sport.
Wir sind gelaufen.
EOF
cat > "$ROOT/berichte/bericht-b.txt" <<'EOF'
Mathe war spannend.
Wir haben Brüche geübt.
Danach gab es Pause.
EOF
cat > "$ROOT/berichte/bericht-c.txt" <<'EOF'
Kunst: Wir haben gemalt.
EOF
echo "✅ Lektion 4 ist bereit."
