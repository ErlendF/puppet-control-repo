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
    # Allow puppetdb_soft_write_failure since consul consensus will not be up and running on first run of puppet
  class { 'puppetdb::master::config':
    manage_report_processor     => true,
    enable_reports              => true,
    puppetdb_server             => $puppetdb_host,
    puppetdb_soft_write_failure => true,
  }

  file {
    default:
      ensure => file,
      owner  => 'root',
      group  => 'root',
    ;
    '/etc/puppetlabs/puppet/eyaml':
      ensure => directory,
      mode   => '0755',
    ;
    '/etc/puppetlabs/puppet/eyaml/private_key.pkcs7.pem':
      group  => 'puppet',
      mode   => '0440',
      source => "puppet:///modules/${module_name}/private_key.pkcs7.pem",
    ;
    '/etc/puppetlabs/puppet/eyaml/public_key.pkcs7.pem':
      mode   => '0444',
      source => "puppet:///modules/${module_name}/eyaml_public_key.pkcs7.pem",
    ;
  }

  package { 'hiera-eyaml puppetserver_gem':
    name     => 'hiera-eyaml',
    provider => 'puppetserver_gem',
  }
}
