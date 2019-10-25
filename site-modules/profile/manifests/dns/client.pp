#
# profile::dns::client
#
class profile::dns::client {

  $man_ip = lookup( 'manager_ip', undef, undef, '1.1.1.1' )

  case $facts['os']['name'] {
    /^(Debian|Ubuntu)$/: {
      class { 'resolv_conf':
        nameservers => [$man_ip, '1.1.1.1'],
      }
    }
    default: { notify { 'Which OS? WTF???': } }
  }
}

