# profile::sensu::agent
class profile::sensu::agent {
  class { 'sensu::agent':
    backends    => ['sensuback.service.consul:8081'],
    config_hash => {
      'subscriptions' => ['linux', 'apache-servers'],
    },
  }
  class { 'sensu::plugins':
    plugins => {
    'disk-checks' => { 'version' => 'latest' },
    },
  }
}
