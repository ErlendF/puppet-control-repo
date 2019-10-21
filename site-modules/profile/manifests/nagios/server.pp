# profile::nagios::server
#
class profile::nagios::server {

  class {'::nagios ':
    server   => true,
    nrpe     => true,
    firewall => true,
    aliases  => 'nagios.iacprosjekt.ntnu',
  }
}
