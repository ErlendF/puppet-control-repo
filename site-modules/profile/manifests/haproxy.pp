#
# ::profile::haproxy
# Sets up the HAproxy service for loadbalancing the web-service 
# and puppetboard/puppetdb
#
class profile::haproxy {
    include ::haproxy
    haproxy::listen { 'forwarder':
      collect_exported => false,
      ipaddress        => '*',
      ports            => '5000',
    }
    haproxy::balancermember { 'puppetserver':
      listening_service => 'forwarder',
      ipaddresses       => 'puppetdb.node.consul',
      ports             => '5000',
      options           => 'check',
    }

    haproxy::listen { 'balancer':
      collect_exported => false,
      ipaddress        => '*',
      ports            => '80',
    }
    haproxy::balancermember { 'lin0':
      listening_service => 'balancer',
      ipaddresses       => 'lin0.node.consul',
      ports             => '8080',
      options           => 'check',
    }
    haproxy::balancermember { 'lin1':
      listening_service => 'balancer',
      ipaddresses       => 'lin1.node.consul',
      ports             => '8080',
      options           => 'check',
    }
}

