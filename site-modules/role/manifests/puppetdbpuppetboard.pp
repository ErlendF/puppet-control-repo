#  
# role::puppetdb
#
class role::puppetdbpuppetboard {
  include ::profile::base_linux
  include ::profile::dns::client
  include ::profile::consul::client
  include ::profile::base_puppetdb
  Class['::profile::dns::client']
    -> Class['::profile::consul::client']
    -> Class['::profile::base_puppetdb']
}
