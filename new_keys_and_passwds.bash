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
if [ ! -f "/root/.ssh/id_rsa" ]; 
then
    ssh-keygen -q -N '' -f /root/.ssh/id_rsa 
fi

# pushes new / current keys in to hiera 
# needs  :postrun: ['/bin/bash', '/etc/puppetlabs/code/environments/production/new_keys_and_passwds.bash'] in r10k.yaml
echo "base_linux::root_ssh_key: $(cut -d ' ' -f 2 /root/.ssh/id_rsa.pub)" >> /etc/puppetlabs/code/environments/production/data/common.yaml

# Define a timestamp function
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}


if [ $? -eq 0 ] ; then
        echo "$(timestamp): r10k-postrun successfull" >> /root/log
        exit 0
else
        echo "$(timestamp): r10k-postrun failed" >> /root/log
        exit 1
fi