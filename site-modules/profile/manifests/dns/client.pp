#
# profile::dns::client
#
class profile::dns::client {

  $dir_ip = lookup( 'Address', undef, undef, '1.1.1.1' )

  case $facts['os']['name'] {
    /^(Debian|Ubuntu)$/: {
      class { 'netplan':
        config_file   => '/etc/netplan/50-cloud-init.yaml',
        ethernets     => {
          'ens3' => {
            'dhcp4'       => true,
            'nameservers' => {
              'search'    => ['node.consul'],
              'addresses' => [ $dir_ip ],
            }
          }
        },
        netplan_apply => true,
      }
    }
    default: { notify { 'Which OS? WTF???': } }
  }

}

