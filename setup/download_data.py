"""Python alternative: python setup/download_data.py [months=3] [YYYY-MM end]"""
import sys, urllib.request, datetime as dt, pathlib
BASE = "https://d37ci6vzurychx.cloudfront.net"
DATA = pathlib.Path(__file__).resolve().parent.parent / "data"; DATA.mkdir(exist_ok=True)
def prev(y, m): return (y - 1, 12) if m == 1 else (y, m - 1)
def url(y, m): return f"{BASE}/trip-data/yellow_tripdata_{y}-{m:02d}.parquet"
def exists(u):
    try: urllib.request.urlopen(urllib.request.Request(u, method="HEAD")); return True
    except Exception: return False
n = int(sys.argv[1]) if len(sys.argv) > 1 else 3
assert 1 <= n <= 3, "months must be 1-3"
if len(sys.argv) > 2: y, m = map(int, sys.argv[2].split("-"))
else:
    t = dt.date.today(); y, m = t.year, t.month
    for _ in range(12):
        if exists(url(y, m)): break
        y, m = prev(y, m)
for _ in range(n):
    p = DATA / f"yellow_tripdata_{y}-{m:02d}.parquet"
    if not p.exists(): print("get", p.name); urllib.request.urlretrieve(url(y, m), p)
    y, m = prev(y, m)
urllib.request.urlretrieve(f"{BASE}/misc/taxi_zone_lookup.csv", DATA / "taxi_zone_lookup.csv")
print("Done. Next: duckdb taxi.duckdb < setup/setup.sql")
