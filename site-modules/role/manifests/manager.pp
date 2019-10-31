#
# role::manager
#
class role::manager {
  contain ::profile::base_linux
  contain ::profile::base_manager
  contain ::profile::dns::client
  contain ::profile::dns::server
  contain ::profile::consul::server
  contain ::profile::mon::telegraf
}
