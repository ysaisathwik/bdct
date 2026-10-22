#!/usr/bin/env python3
import sys
current = None
count = success_count = 0
total = success_total = 0.0

def emit(key, n, amount, sn, sa):
    if key is not None:
        print(f"{key}\t{n}\t{amount:.2f}\t{sn}\t{sa:.2f}")

for line in sys.stdin:
    try:
        key, vals = line.strip().split("\t", 1)
        n, amount, sn, sa = vals.split(",")
        n, sn, amount, sa = int(n), int(sn), float(amount), float(sa)
    except ValueError:
        print(f"Skipping malformed mapper output: {line.rstrip()}", file=sys.stderr); continue
    if current is not None and key != current:
        emit(current, count, total, success_count, success_total)
        count = success_count = 0
        total = success_total = 0.0
    current = key
    count += n; total += amount
    success_count += sn; success_total += sa
emit(current, count, total, success_count, success_total)
