#
# profile::puppetdb
#
class profile::puppetdb {

  $puppetdb_host = lookup('puppetdb::puppetdb_host')
  $postgres_host = lookup('puppetdb::postgres_host')

  # Here we install and configure PostgreSQL and the PuppetDB
  class { 'puppetdb':
    listen_address => '0.0.0.0',
    report_ttl     => '14d'
  }

  # Configure Apache
  class { 'apache':
    mpm_module    => 'prefork',
  }
  class { 'apache::mod::wsgi': }

  # Configure Puppetboard
  class { 'puppetboard':
    manage_git          => true,
    manage_virtualenv   => true,
    default_environment => '*',
  }

  # Configure vhost for puppetboard
  class { 'puppetboard::apache::vhost':
        vhost_name => $puppetdb_host,
  }

  consul::service { 'puppetdb':
  checks => [
    {
      tcp      => 'localhost:8081',
      interval => '10s',
    }
  ],
  port   => 5432,
  }
}

