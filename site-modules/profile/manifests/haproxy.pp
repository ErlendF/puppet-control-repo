#
# ::profile::haproxy
#
class profile::haproxy {
    notify { "min ip er ${facts['networking']['ip']}": }

    # $isp = lookup('haproxy::ip')

    include ::haproxy
    haproxy::listen { 'balancer':
      collect_exported => false,
      ipaddress        => $facts['networking']['ip'],
      ports            => '80',
    }
    haproxy::balancermember { 'puppetserver':
      listening_service => 'balancer',
      ipaddresses       => '10.212.138.211',
      ports             => '5000',
      options           => 'check',
    }
}

