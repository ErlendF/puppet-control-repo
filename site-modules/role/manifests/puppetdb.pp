#  
# role::puppetdb
#
class role::puppetdb {
  include ::profile::base_linux
  include ::profile::dns::client
  include ::profile::consul::client
  include ::profile::base_puppetdb
}
