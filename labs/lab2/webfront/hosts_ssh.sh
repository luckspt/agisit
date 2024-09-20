#!/usr/bin/env bash

# Only allow key based logins
# Matches whitespace characters (spaces and tabs). 
# Newlines embedded in the pattern/hold spaces will also match:
# (#PasswordAuthentication yes)
# (PasswordAuthentication yes)
# (PasswordAuthentication no)

sudo sed -i 's/^\s*#\?PasswordAuthentication\s*\(yes\|no\)\s*$/PasswordAuthentication yes/' /etc/ssh/sshd_config
# Apply to all .conf files that may be included in /etc/ssh/sshd_config -- suppress any error if no file is found
sudo sed -i 's/^\s*#\?PasswordAuthentication\s*\(yes\|no\)\s*$/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/*.conf 2>/dev/null
sudo systemctl restart sshd
