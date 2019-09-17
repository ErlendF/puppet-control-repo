#!/bin/bash

# create new passwords for all hiera keys ending with 'password'
#while read -r entry
#do
#  filename=$(echo "$entry" | cut -d ':' -f1)
#  key=$(echo "$entry" | cut -d ':' -f1 --complement)
#  blank_key=$(echo "$key" | grep -oE '^.*password:')
#  sed -i -E "s/($blank_key).*/\1 $(pwgen -s 16 1)/" "$filename"
#done < <(grep -rH 'password:' hieradata/*)

# Create a passwordless keypair for root ssh
ssh-keygen -q -N '' -f /root/.ssh/id_rsa
echo "base_linux::root_ssh_key: $(cut -d ' ' -f 2 /root/.ssh/id_rsa.pub)" >> hieradata/common.yaml
