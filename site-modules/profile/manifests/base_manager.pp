#
# profile::base_manager
#
class profile::base_manager {
# users should be able to ssh without password to manager
  $ssh_key_johan = lookup('base_manager::ubuntu_ssh_key_johan')
  $ssh_key_erlend = lookup('base_manager::ubuntu_ssh_key_erlend')
  $ssh_key_aksel = lookup('base_manager::ubuntu_ssh_key_aksel')

  file { '/home/ubuntu/.ssh':
    ensure => 'directory',
    owner  => 'ubuntu',
    group  => 'ubuntu',
    mode   => '0700',
  }
  ssh_authorized_key { 'johan@manjaro':
    ensure => present,
    user   => 'ubuntu',
    type   => 'ssh-rsa',
    key    => $ssh_key_johan,
  }
  ssh_authorized_key { 'erlend@ubuntututu':
    ensure => present,
    user   => 'ubuntu',
    type   => 'ssh-rsa',
    key    => $ssh_key_erlend,
  }
  ssh_authorized_key { 'akselba@loginstud01':
    ensure => present,
    user   => 'ubuntu',
    type   => 'ssh-rsa',
    key    => $ssh_key_aksel,
  }


    # Tell Puppet master to use PuppetDB and hostname of the PuppetDB node
  class { 'puppetdb::master::config':
    manage_report_processor => true,
    enable_reports          => true
  }

  # Here we install and configure PostgreSQL and the PuppetDB
  # database instance, and tell PostgreSQL that it should
  # listen for connections to the `$postgres_host`
  class { 'puppetdb':
    listen_address => '0.0.0.0',
    report_ttl     => '7d'
  }


  # Configure Apache
  # Ensure it does *not* purge configuration files
  # Configure Apache
  # Ensure it does *not* purge configuration files
  class { 'apache':
    mpm_module    => 'prefork',
  }

  class { 'apache::mod::wsgi': }

  # Configure Puppetboard
  class { 'puppetboard':
    manage_git          => true,
    manage_virtualenv   => true,
    unresponsive        => '1',
    default_environment => '*',
    }

  ## Access Puppetboard from manager.node.consul/puppetboard
  #class { 'puppetboard::apache::conf': }
  # }

    # Configure vhost for puppetboard
    class { 'puppetboard::apache::vhost':
        vhost_name => '*',
    }
