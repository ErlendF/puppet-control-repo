# profile::nagios::server
#
class profile::nagios::server {
  class { 'nagios::server::config':
    monitoring_environment => 'production',
    password               => 'nagios_password'
  }

  consul::service { 'nagios':
  checks => [
    {
      tcp      => 'localhost:80',
      interval => '10s',
    }
  ],
  port   => 80,
  }
}
