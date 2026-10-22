#!/usr/bin/env python3
import csv, sys
for line in sys.stdin:
    try:
        row = next(csv.reader([line.rstrip("\n")]))
        if not row or row[0].strip().lower() == "transaction_id":
            continue
        if len(row) != 8:
            print("Skipping malformed row", file=sys.stderr); continue
        kind, amount, status = row[3].strip().upper(), float(row[4]), row[7].strip().upper()
        success = 1 if status == "SUCCESS" else 0
        print(f"{kind}\t1,{amount:.2f},{success},{amount if success else 0:.2f}")
    except (ValueError, csv.Error, StopIteration) as e:
        print(f"Skipping invalid row: {e}", file=sys.stderr)
