#
# role::manager
#
class role::manager {
  include ::profile::base_linux
  include ::profile::dns::client
  include ::profile::consul::server
  include ::profile::base_manager
}
