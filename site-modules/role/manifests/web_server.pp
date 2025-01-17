#  
# role::web_server
#
class role::web_server {
  include ::profile::base_linux
  include ::profile::dns::client
  include ::profile::consul::client
  include ::profile::webserver::golang_api
  include ::profile::mon::telegraf
}
