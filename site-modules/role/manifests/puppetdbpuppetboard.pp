#  
# role::puppetdb
#
class role::puppetdbpuppetboard {
  include ::profile::base_linux
  include ::profile::dns::client
  include ::profile::consul::server
  include ::profile::base_puppetdb
}
