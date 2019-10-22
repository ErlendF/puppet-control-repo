# profile::nagios::client
#
class profile::nagios::client {

  class {'nagios::client':
    nagios_service         => 'generic_service',
    monitoring_environment => $::environment
  }

  class {'nagios::nrpe::config':
    server                 => '192.168.1.1',
    nagios_service         => 'generic_service',
    monitoring_environment => $::environment
  }
}
