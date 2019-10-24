#
# profile::consul::server
#
class profile::consul::server {

  package { 'unzip':
    ensure => latest,
  }
  # needs 3 server nodes to establish consensus
  class { '::consul':
    version     => '1.6.0',
    config_hash => {
      'client_addr'      => '0.0.0.0',  ## make ui reachable
      'ui'               => true,       ## add ui
      'bootstrap_expect' => 3,
      'data_dir'         => '/opt/consul',
      'datacenter'       => 'NTNU',
      'log_level'        => 'INFO',
      'node_name'        => $facts['hostname'],
      'server'           => true,
      'retry_join'       => [ $::serverip ],
    },
    require     => Package['unzip'],
  }
}

