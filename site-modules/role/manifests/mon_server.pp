#  
# role::mon_server
#
class role::mon_server {
  include ::profile::base_linux
  include ::profile::dns::client
  include ::profile::consul::client
  include ::profile::sensu::backend
  include ::profile::sensu::agent
}
