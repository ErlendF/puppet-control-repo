#  
# role::loadbalancer
#
class role::loadbalancer {
  include ::profile::base_linux
  include ::profile::dns::client
  include ::profile::consul::client
  include ::profile::nginx
  Class['::profile::consul::client'] -> Class['::profile::nginx']
}
