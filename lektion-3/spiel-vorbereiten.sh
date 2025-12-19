#!/usr/bin/env bash
set -u
ROOT="spiel"
rm -rf "$ROOT"
mkdir -p "$ROOT/zimmer-jakob"/{schreibtisch,boden,schrank}
mkdir -p "$ROOT/zimmer-sophia"/{schreibtisch,boden,schrank}
mkdir -p "$ROOT/keller"/{regal,ecke}
echo "Einkaufsliste" > "$ROOT/zimmer-jakob/boden/zettel.txt"
echo "Hausaufgaben" > "$ROOT/zimmer-sophia/schreibtisch/notiz.txt"
echo "Ganz normaler Text" > "$ROOT/keller/ecke/text.txt"
cat > "$ROOT/zimmer-jakob/schrank/hinweis-rot.txt" <<'EOF'
Das ist ein Hinweis.
CODE: DRACHE
EOF
cat > "$ROOT/zimmer-sophia/boden/hinweis-blau.txt" <<'EOF'
Noch ein Hinweis.
CODE: 42
EOF
cat > "$ROOT/keller/regal/hinweis-alt.txt" <<'EOF'
Das sieht wichtig aus,
aber hier steht kein Code.
EOF
echo "✅ Lektion 3 ist bereit."
