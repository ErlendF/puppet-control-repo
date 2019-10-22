# profile::nagios::client
#
class profile::nagios::client {

  class {'nagios::client ':
    basic_checks => true,
    nrpe         => true,
    firewall     => true,
    aliases      => 'nagios.iacprosjekt.ntnu',
  }
}
