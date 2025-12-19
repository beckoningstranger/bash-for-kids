#!/usr/bin/env bash
set -u

ROOT="spiel"
rm -rf "$ROOT"

mkdir -p "$ROOT"/{logs,bericht}

# Deterministic-ish content: fixed counts per robot
# We'll create 8 robots with different numbers of WARNUNG/FEHLER/OK lines plus noise.
robots=8

for r in $(seq -w 1 $robots); do
  f="$ROOT/logs/roboter-${r}.log"
  : > "$f"

  # noise lines
  for i in $(seq 1 40); do
    echo "INFO Maschine${r} Schritt${i}: abcDEFxyz" >> "$f"
  done

  # OK lines (varies)
  ok=$((20 + 2*10#$r))
  for i in $(seq 1 $ok); do
    echo "OK Maschine${r}: Teil ${i} geprüft" >> "$f"
  done

  # WARNUNG lines (varies)
  warn=$((3 + (10#$r % 4)))
  for i in $(seq 1 $warn); do
    echo "WARNUNG Maschine${r}: Temperatur hoch (${i})" >> "$f"
  done

  # FEHLER lines (varies)
  err=$((1 + (10#$r % 3)))
  for i in $(seq 1 $err); do
    echo "FEHLER Maschine${r}: Sensor${i} reagiert nicht" >> "$f"
  done

  # more noise
  for i in $(seq 1 15); do
    echo "DEBUG Maschine${r}: qwertYUIOP" >> "$f"
  done
done

echo "✅ Lektion 5 ist bereit."
echo "Tipp: cd spiel && ls logs"
