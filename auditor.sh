#!/bin/bash
mkdir -p ./logs
VULN_COUNT=$(find $HOME -type f -perm -o+w 2>/dev/null | wc -l)
PASSWD_PERMS=$(stat -c "%a" /etc/passwd 2>/dev/null)
cat<< EOF> ./logs/audit.json
{
  "timestamp": "$(date -Iseconds)",
  "user": "$(whoami)",
  "metrics": {
    "world_writable_files":$VULN_COUNT,
    "passwd_permissions":$PASSWD_PERMS
  }
}
EOF
echo "logs saved"
