#  
# role::postgres_server
#
class role::postgres_server {
  include ::profile::postgresql
  include ::profile::base_linux
  include ::profile::dns::client
  include ::profile::consul::client
}
