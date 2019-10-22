# profile::nagios::client
#
class profile::sensu::agent {

  class { 'sensu::agent':
    backends    => ['sensu-backend.example.com:8081'],
    config_hash => {
      'subscriptions' => ['linux', 'apache-servers'],
    },
  }
}
