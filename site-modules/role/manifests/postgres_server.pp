#  
# role::postgres_server
# a little attemt at understanding diff between contain & include
#
class role::postgres_server {
  contain ::profile::base_linux
  contain ::profile::dns::client
  contain ::profile::consul::client
  contain ::profile::postgresql
  #Class['::profile::consul::client'] -> Class['::profile::postgresql'] # for future use (when consul data is needed )
}
