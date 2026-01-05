#!/usr/bin/env bash
set -u

echo "🔄 Neustart: Spiel wird zurückgesetzt..."
bash "$(cd "$(dirname "$0")" && pwd)/spiel-vorbereiten.sh"
echo "✅ Fertig. Du kannst wieder neu starten."
