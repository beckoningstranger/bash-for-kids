#!/usr/bin/env bash
set -u

ROOT="spiel"
rm -rf "$ROOT"

mkdir -p "$ROOT"/{logs,bericht}

# 6 Roboter, mit festen, aber unterschiedlichen Mengen
for r in $(seq -w 1 6); do
  f="$ROOT/logs/roboter-${r}.log"
  : > "$f"

  # INFO
  for i in $(seq 1 25); do
    echo "INFO Maschine${r}: Schritt${i}" >> "$f"
  done

  # WARNUNG: r+2 Zeilen
  for i in $(seq 1 $((10#$r + 2))); do
    echo "WARNUNG Maschine${r}: Temperatur hoch (${i})" >> "$f"
  done

  # FEHLER: (r % 3) + 1 Zeilen
  for i in $(seq 1 $(( (10#$r % 3) + 1 ))); do
    echo "FEHLER Maschine${r}: Sensor${i} reagiert nicht" >> "$f"
  done

  # OK: 10+r Zeilen (beginnt mit "OK ")
  for i in $(seq 1 $((10 + 10#$r))); do
    echo "OK Maschine${r}: Teil ${i} geprüft" >> "$f"
  done

  # DEBUG
  for i in $(seq 1 10); do
    echo "DEBUG Maschine${r}: xYz${i}" >> "$f"
  done
done

echo "✅ Lektion 6 ist bereit."
echo "Tipp: cd spiel && ls logs"
