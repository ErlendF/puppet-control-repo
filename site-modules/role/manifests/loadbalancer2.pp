#  
# role::loadbalancer
#
class role::loadbalancer2 {
  contain ::profile::base_linux
  contain ::profile::dns::client
  contain ::profile::consul::client
  contain ::profile::nginx
  Class['::profile::consul::client'] -> Class['::profile::nginx']
}
