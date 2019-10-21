#
# ::profile::haproxy
# Sets up the HAproxy service for loadbalancing the web-service 
# and puppetboard/puppetdb
#
class profile::nginx {

    class{'nginx':
    manage_repo    => true,
    package_source => 'nginx-stable'
    }

    nginx::resource::server { 'puppetdb.iacprosjekt.ntnu':
    listen_port => 80,
    proxy       => 'http://puppetdb.service.consul:5000',
    }

    nginx::resource::server { 'consul.iacprosjekt.ntnu':
    listen_port => 80,
    proxy       => 'http://consul.service.consul:8500/',
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

