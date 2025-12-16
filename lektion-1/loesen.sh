#!/usr/bin/env bash
set -u

echo "LEVEL-ABSCHLUSS: Lektion 1 ✅"
echo
echo "Frage: Wo liegt der Schatz?"
echo "(Wähle eine Antwort aus der Liste.)"
echo

options=(
  "im Wald, in der Höhle"
  "im Wald, an der Lichtung"
  "im Wald, am Fluss"
  "auf dem Berg, am Gipfel"
  "auf dem Berg, in der Höhle"
  "im Dorf, im Haus"
  "im Dorf, im Turm"
  "am Meer, am Strand"
  "am Meer, auf der Insel, unter den Palmen, in der Höhle"
  "im Dorf, am Markt"
)

PS3="Deine Wahl (1-10): "
select choice in "${options[@]}"; do
  if [[ -z "${choice:-}" ]]; then
    echo "Bitte eine Zahl von 1 bis 10 wählen."
    continue
  fi

  if [[ "$REPLY" == "9" ]]; then
    echo
    echo "🎉 Richtig!"
    echo "Du hast Lektion 1 abgeschlossen."
    echo

    mkdir -p "$HOME/bash-lernstand"
    echo "Lektion 1 geschafft! 🏆" > "$HOME/bash-lernstand/lektion-1-geschafft.txt"

    LEX="$HOME/bash-lexikon.txt"
    cat > "$LEX" <<'EOF'
BASH-LEXIKON 📘 (Stand: Lektion 1)
Lies diese Datei mit: less ~/bash-lexikon.txt
(less: Space runter, b hoch, q beenden)

Alphabetisch sortiert:

cat
- Zeigt den Inhalt einer Datei im Terminal.
  Beispiel: cat schatz.txt
  Beispiel: cat ANLEITUNG.txt

cd
- Wechselt den Ordner.
  Beispiel: cd spiel
  Beispiel: cd ..

less
- Liest eine Datei zum Scrollen.
  Beispiel: less ANLEITUNG.txt
  Beispiel: less ~/bash-lexikon.txt

ls
- Listet Dateien und Ordner auf.
  Beispiel: ls
  Beispiel: ls -l

pwd
- Zeigt den aktuellen Ordner.
  Beispiel: pwd
EOF

    echo "✅ Lexikon erstellt: $LEX"
    echo "✅ Erfolg gespeichert: $HOME/bash-lernstand/lektion-1-geschafft.txt"
    exit 0
  else
    echo
    echo "❌ Das ist nicht richtig."
    echo "Tipp: Denk an den Merksatz aus schatz.txt."
    echo "Lies die Datei zur Not nochmal mit cat oder less."
    exit 1
  fi
done
