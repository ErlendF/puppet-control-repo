# profile::sensu::agent
class profile::sensu::agent {
#  class { 'sensu::agent':
#    backends    => ['sensuback.service.consul:8081'],
#    config_hash => {
#      'subscriptions' => ['linux', 'apache-servers'],
#    },
#  }
#
#  sensu_check { 'check-cpu':
#    ensure        => 'present',
#    command       => 'check-cpu.sh -w 75 -c 90',
#    interval      => 60,
#    subscriptions => ['linux'],
#  }
#
#  package { 'sensu-plugins-disk-checks':
#    ensure   => 'latest',
#    provider => sensu_gem,
#  }
#  class { 'sensu::plugins':
#    plugins => {
#    'disk-checks' => { 'version' => 'latest' },
#    },
#  }
}
