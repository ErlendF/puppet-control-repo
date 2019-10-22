# profile::sensu::agent
class profile::sensu::agent {
  class { 'sensu::agent':
    backends    => ['sensuback.service.consul:8081'],
    config_hash => {
      'subscriptions' => ['linux', 'apache-servers'],
    },
  }
  package { 'sensu-plugins-disk-checks':
    ensure   => '0.0.1',
    provider => sensu_gem,
  }
  class { 'sensu::plugins':
    plugins => {
    'disk-checks' => { 'version' => 'latest' },
    },
  }
}
