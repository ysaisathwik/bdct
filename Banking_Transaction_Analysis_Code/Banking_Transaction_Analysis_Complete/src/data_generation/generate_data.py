import csv, random
from datetime import datetime, timedelta
from pathlib import Path

N = 1000
OUT = Path(__file__).resolve().parents[2] / "data/raw/bank_transactions.csv"
TYPES = ["DEPOSIT", "WITHDRAWAL", "TRANSFER", "PAYMENT"]
MERCHANTS = ["ATM", "Online", "Shopping", "Groceries", "Branch", "Restaurant", "Electricity"]
CITIES = ["Hyderabad", "Nizamabad", "Warangal", "Karimnagar", "Vijayawada"]
STATUSES = ["SUCCESS", "FAILED", "PENDING"]

def main():
    random.seed(42)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    start = datetime(2026, 1, 1)
    with OUT.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["transaction_id","customer_id","transaction_date","transaction_type","amount","merchant","city","status"])
        for i in range(1, N + 1):
            dt = start + timedelta(days=random.randint(0,299), seconds=random.randint(0,86399))
            w.writerow([f"T{i:05d}", f"C{random.randint(101,200):03d}",
                dt.strftime("%Y-%m-%d %H:%M:%S"), random.choice(TYPES),
                f"{random.uniform(100,100000):.2f}", random.choice(MERCHANTS),
                random.choice(CITIES), random.choices(STATUSES, weights=[90,7,3], k=1)[0]])
    print(f"Created {N} synthetic transactions: {OUT}")

if __name__ == "__main__":
    main()
