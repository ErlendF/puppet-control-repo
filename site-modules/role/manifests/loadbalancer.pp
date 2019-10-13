#  
# role::loadbalancer
#
class role::loadbalancer {
  contain ::profile::base_linux
  contain ::profile::dns::client
  contain ::profile::consul::client
  contain ::profile::haproxy
  Class['::profile::consul::client'] -> Class['::profile::haproxy']
}
