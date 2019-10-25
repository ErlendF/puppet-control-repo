# profile::sensu::agent
class profile::sensu::agent {

  class { 'sensu::agent':
    backends    => ['sensuback.service.consul:8081'],
    config_hash => {
      'subscriptions' => ['linux', 'apache-servers'],
    },
  }

  class { 'sensu::plugins':
    plugins          => ['memory-checks', 'disk-checks'],
    gem_dependencies => ['vmstat'],
  }
}
