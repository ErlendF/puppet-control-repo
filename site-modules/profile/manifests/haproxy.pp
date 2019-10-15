#
# ::profile::haproxy
#
class profile::haproxy {
    notify { "min ip er ${facts['networking']['ip']}": }

    # $isp = lookup('haproxy::ip')

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

