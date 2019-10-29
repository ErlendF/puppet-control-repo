#  
# role::directory_server
#
class role::directory_server {
  include ::profile::base_linux
  include ::profile::dns::client
  include ::profile::consul::server
  include ::profile::mon::telegraf
}
