#
# profile::dns::server
#

class profile::dns::server {
  dnsmasq::conf { 'local-dns':
    ensure => present,
    source => "puppet:///modules/${module_name}/local-dns",
  }
}

