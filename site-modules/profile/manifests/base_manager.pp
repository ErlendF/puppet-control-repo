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

  package { 'toml-rb':
    ensure   => present,
    provider => puppetserver_gem,
    notify   => Service['puppetserver']
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
    # Allow puppetdb_soft_write_failure since consul consensus will not be up and running on first run of puppet
  class { 'puppetdb::master::config':
    manage_report_processor     => true,
    enable_reports              => true,
    puppetdb_server             => $puppetdb_host,
    puppetdb_soft_write_failure => true,
  }

  file { '/etc/puppetlabs/puppet/eyaml':
    ensure => directory,
    mode   => '0755',
    owner  => root,
    group  => puppet,
  }

  file { '/etc/puppetlabs/puppet/eyaml/public_key.pkcs7.pem':
    ensure  => file,
    owner   => root,
    group   => puppet,
    mode    => '0444',
    source  => "puppet:///modules/${module_name}/public_key.pkcs7.pem",
    require => File['/etc/puppetlabs/puppet/eyaml'],
  }

  file { '/etc/puppetlabs/puppet/eyaml/private_key.pkcs7.pem':
    ensure  => file,
    owner   => root,
    group   => puppet,
    mode    => '0440',
    source  => "puppet:///modules/${module_name}/private_key.pkcs7.pem",
    require => File['/etc/puppetlabs/puppet/eyaml'],
  }

  package { 'hiera-eyaml puppetserver_gem':
    name     => 'hiera-eyaml',
    provider => 'puppetserver_gem',
  }

}
