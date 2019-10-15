#
# ::profile::haproxy
# Sets up the HAproxy service for loadbalancing the web-service
#
class profile::haproxy {
    include ::haproxy
    haproxy::listen { 'balancer':
      collect_exported => false,
      ipaddress        => '*',
      ports            => '80',
    }
    haproxy::balancermember { 'puppetserver':
      listening_service => 'balancer',
      ipaddresses       => 'puppetdb.node.consul',            # get from consul for dynamic(?)
      ports             => '5000',
      options           => 'check',
    } 
}

