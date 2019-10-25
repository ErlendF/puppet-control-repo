#
# profile::dns::client
#
class profile::dns::client {
  $man_ip = lookup('manager_ip')

  case $facts['os']['name'] {
    /^(Debian|Ubuntu)$/: {
      class { 'resolv_conf':
        # resolve asks the ips in this list in order giving priority to the first 
        nameservers => [$man_ip, '1.1.1.1'],
      }
    }
    default: { notify { 'Which OS? WTF???': } }
  }
}

