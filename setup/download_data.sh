#!/usr/bin/env bash
# Usage: setup/download_data.sh [MONTHS=3] [END_MONTH=YYYY-MM]
# Downloads the most recent N published months (1-3) of NYC TLC yellow taxi data.
set -euo pipefail
MONTHS="${1:-3}"; END="${2:-}"
[[ "$MONTHS" =~ ^[1-3]$ ]] || { echo "MONTHS must be 1-3"; exit 1; }
BASE="https://d37ci6vzurychx.cloudfront.net"
DIR="$(cd "$(dirname "$0")/.." && pwd)/data"; mkdir -p "$DIR"
ok(){ curl -sfI "$BASE/trip-data/yellow_tripdata_$1.parquet" >/dev/null; }
prev(){ date -d "$1-01 -1 month" +%Y-%m 2>/dev/null || date -j -v-1m -f %Y-%m-%d "$1-01" +%Y-%m; }
if [[ -z "$END" ]]; then END=$(date +%Y-%m); for _ in $(seq 1 12); do ok "$END" && break; END=$(prev "$END"); done; fi
m="$END"
for _ in $(seq 1 "$MONTHS"); do
  f="yellow_tripdata_$m.parquet"
  if [[ -s "$DIR/$f" ]]; then echo "have $f"; else echo "get $f"; curl -fL --retry 3 -o "$DIR/$f" "$BASE/trip-data/$f"; fi
  m=$(prev "$m")
done
curl -fsSL -o "$DIR/taxi_zone_lookup.csv" "$BASE/misc/taxi_zone_lookup.csv"
echo "Done. Next: duckdb taxi.duckdb < setup/setup.sql"
