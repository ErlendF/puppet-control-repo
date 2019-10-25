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

    nginx::resource::server { 'sensu.iacprosjekt.ntnu':
    listen_port => 80,
    proxy       => 'https://sensuback.service.consul:3000',
    }

    nginx::resource::server { 'consul.iacprosjekt.ntnu':
    listen_port => 80,
    proxy       => 'http://consul.service.consul:8500/',
    }

    nginx::resource::upstream { 'web_api':
      members => {
        'web.service.consul:80' => {
          server => 'http://web.service.consul/',
          port   => 80,
          weight => 1,
          },
        'lin0.node.consul:80'   => {
          server => 'http://lin0.node.consul/',
          port   => 80,
          weight => 2,
          },
        'lin1.node.consul:80'   => {
          server => 'http://lin1.node.consul/',
          port   => 80,
          weight => 2,
          },
        },
      }

    nginx::resource::server { 'iacprosjekt.ntnu':
      proxy => 'http://web_api',
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

