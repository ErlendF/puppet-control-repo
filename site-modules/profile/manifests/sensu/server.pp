# profile::nagios::server
#
class profile::sensu::backend {
  class { 'sensu::backend':
    password     => 'supersecret',
    old_password => 'P@ssw0rd!',
  }
  include sensu::agent
    sensu_check { 'check-cpu':
    ensure        => 'present',
    command       => 'check-cpu.sh -w 75 -c 90',
    interval      => 60,
    subscriptions => ['linux'],
  }
}
