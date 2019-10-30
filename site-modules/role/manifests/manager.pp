#
# role::manager
#
class role::manager {
  include ::profile::base_linux
  include ::profile::base_manager
  include ::profile::dns::client
  include ::profile::dns::server
  include ::profile::consul::server
  Class['::profile::base_manager'] -> Class['::profile::mon::telegraf']
  include ::profile::mon::telegraf
}
