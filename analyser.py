import json
import os
import sys

FILE = "./logs/audit.json"

def health():
    if not os.path.exists(FILE):
        print("Log file not found")
        sys.exit(1)
        
    with open(FILE, 'r') as file:
        data = json.load(file)
        
    print("=" * 40)
    print("PYTHON STUFF")
    print(f"Scan Time: {data['timestamp']}")
    print(f"Target User: {data['user']}")
    print("=" * 40) 
    
    metrics = data.get("metrics", {})
    critical_alerts = 0
    warnings = 0
    
    writable_files = metrics.get("world_writable_files", 0)
    if writable_files > 0:
        print(f"Number of world-writable files found={writable_files}")
        warnings += 1
    else:
        print("No world writable files found")
        
    passwd_perms = metrics.get("passwd_permissions", 644)
    if passwd_perms != 644:
        print(f"Insecure files detected\n {passwd_perms}")
        critical_alerts += 1
    else:
        print("No insecure files detected:")
if __name__ == "__main__":
    health()
