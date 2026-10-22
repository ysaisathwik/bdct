import csv
from pathlib import Path
CSV_FILE = Path(__file__).resolve().parents[2] / "data/raw/bank_transactions.csv"
EXPECTED = ["transaction_id","customer_id","transaction_date","transaction_type","amount","merchant","city","status"]

def main():
    if not CSV_FILE.exists():
        raise SystemExit("CSV not found. Run src/data_generation/generate_data.py first.")
    total = invalid = 0
    with CSV_FILE.open(newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        if reader.fieldnames != EXPECTED:
            raise SystemExit(f"Unexpected columns: {reader.fieldnames}")
        for r in reader:
            total += 1
            try:
                float(r["amount"])
                if not r["transaction_id"] or not r["customer_id"]: invalid += 1
            except (ValueError, TypeError): invalid += 1
    print(f"Rows checked: {total}; invalid rows: {invalid}")
    if total == 0 or invalid: raise SystemExit("Validation failed")
    print("Validation passed")

if __name__ == "__main__": main()
