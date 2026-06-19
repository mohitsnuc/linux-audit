#!bin/bash
mkdir -p ./logs
#vulverability count
VULN_COUNT=$(find $HOME -type f -perm -o+w 2>/dev/null | wc -l)
#password permissions
passwdper=$(stat -c "%a" /etc/passwd)
#constructing the json file
cat<<EOF > ./logs/audit.json
{
  "timestamp": "$(date -Iseconds)",
  "user": "$(whoami)",
  "metrics": {
    "world_writable_files": $VULN_COUNT,
    "passwd_permissions": $passwdper
  }
}
EOF


