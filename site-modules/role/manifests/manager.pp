#
# role::manager
#
class role::manager {
  include ::profile::dns::client
  include ::profile::dns::server
  include ::profile::consul::server
  include ::profile::base_linux
  Class['::profile::base_manager'] ->
  Class['::profile::mon::telegraf']
}
