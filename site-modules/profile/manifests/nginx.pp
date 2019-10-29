#
# ::profile::nginx
#
class profile::nginx {
  $servers = lookup('nginx::servers')

  class{'nginx':
    manage_repo    => true,
    package_source => 'nginx-stable'
  }

  #adds each server declared in hiera
  $servers.each |Hash $server_hash| {
    $server_hash.each |String $name, String $proxy| {
      nginx::resource::server { $name:
        listen_port => 80,
        proxy       => $proxy,
      }
    }
  }

  consul::service { 'nginx':
    checks => [
      {
        tcp      => 'localhost:80',
        interval => '10s',
      }
    ],
    port   => 80,
  }
}

