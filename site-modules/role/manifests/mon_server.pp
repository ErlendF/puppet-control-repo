#  
# role::mon_server
#
class role::mon_server {
  contain ::profile::base_linux
  contain ::profile::dns::client
  contain ::profile::consul::client
  contain ::profile::nagios::server
}
