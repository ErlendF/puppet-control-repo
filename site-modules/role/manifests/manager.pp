#
# role::manager
#
class role::manager {
  include ::profile::base_linux
  include ::profile::base_manager
  include ::profile::dns::client
  include ::profile::dns::server
  include ::profile::consul::server
  include ::profile::mon::telegraf

  Class['::profile::base_linux'] -> Class['::profile::mon::telegraf']
}
