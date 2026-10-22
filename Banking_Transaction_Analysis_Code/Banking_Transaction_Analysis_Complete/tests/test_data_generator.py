import subprocess, sys
from pathlib import Path
root = Path(__file__).resolve().parents[1]
subprocess.run([sys.executable, str(root / "src/data_generation/generate_data.py")], check=True)
csv_path = root / "data/raw/bank_transactions.csv"
assert csv_path.exists()
assert len(csv_path.read_text(encoding="utf-8").splitlines()) == 1001
print("Dataset generator test passed.")
