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

    # nginx::resource::server { 'puppetdb.iacprosjekt.ntnu':
    # listen_port => 80,
    # proxy       => 'http://puppetdb.service.consul:5000',
    # }

    # nginx::resource::server { 'sensu.iacprosjekt.ntnu':
    # listen_port => 80,
    # proxy       => 'https://sensuback.service.consul:3000',
    # }

    # nginx::resource::server { 'consul.iacprosjekt.ntnu':
    # listen_port => 80,
    # proxy       => 'http://consul.service.consul:8500/',
    # }

    # nginx::resource::server { 'iacprosjekt.ntnu':
    # listen_port => 80,
    # proxy       => 'http://web.service.consul/',
    # }


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

