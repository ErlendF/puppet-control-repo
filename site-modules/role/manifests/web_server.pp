#  
# role::directory_server
#
class role::web_server {
  include ::profile::base_linux
  include ::profile::dns::client
  include ::profile::consul::client
  include ::profile::golang
}
