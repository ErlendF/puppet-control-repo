#
# profile::base_manager
#
class profile::base_manager {
# users should be able to ssh using public key to manager
  $ssh_keys = lookup('base_manager::ubuntu_ssh_keys')

  file { '/home/ubuntu/.ssh':
    ensure => 'directory',
    owner  => 'ubuntu',
    group  => 'ubuntu',
    mode   => '0700',
  }

  #adds each key from the ssh_keys array to autorized_keys
  $ssh_keys.each |Hash $key_hash| {
    $key_hash.each |String $name, String $key| {
      ssh_authorized_key { $name:
            ensure  => present,
            user    => 'ubuntu',
            type    => 'ssh-rsa',
            key     => $key,
            require => File['/home/ubuntu/.ssh'],
      }
    }
  }

  $puppetdb_host = lookup('puppetdb::puppetdb_host')
    # Tell Puppet master to use PuppetDB and hostname of the PuppetDB node
  class { 'puppetdb::master::config':
    manage_report_processor     => true,
    enable_reports              => true,
    puppetdb_server             => $puppetdb_host,
    puppetdb_soft_write_failure => true,
  }
}
