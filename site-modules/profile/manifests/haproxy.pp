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
    }
}

