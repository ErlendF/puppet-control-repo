#  
# role::postgres_server
# a little attemt at understanding diff between contain & include
#
class role::postgres_server {
  contain ::profile::base_linux
  contain ::profile::dns::client
  contain ::profile::consul::client
  contain ::profile::base_postgresql
  #Class['::profile::consul::client'] -> Class['::profile::base_postgresql'] # for future use (if consul data is needed )
}
