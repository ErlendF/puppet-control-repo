#  
# role::postgres_server
# a little attemt at understanding diff between contain & include
#
class role::postgres_server {
  include ::profile::base_linux
  include ::profile::dns::client
  include ::profile::consul::client
  include ::profile::postgresql
  include ::profile::mon::telegraf
  #Class['::profile::consul::client'] -> Class['::profile::postgresql'] # for future use (when consul data is needed )
  #include ::profile::sensu::agent
}
