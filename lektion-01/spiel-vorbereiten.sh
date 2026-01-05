#!/usr/bin/env bash
set -u
ROOT="spiel"
rm -rf "$ROOT"
mkdir -p "$ROOT"/{wald/{hoehle,lichtung,fluss},berg/{pfad,gipfel,hoehle},dorf/{haus,markt,turm},meer/{strand,insel/{palmen,hoehle}}}
cat > "$ROOT/meer/insel/hoehle/schatz.txt" <<'EOF'
🏆 SCHATZ GEFUNDEN! 🏆

Merksatz für Papa:
"Der Schatz war am Meer, auf der Insel, in der Höhle."

Super gemacht! 🎉
EOF
echo "✅ Lektion 1 ist bereit."
