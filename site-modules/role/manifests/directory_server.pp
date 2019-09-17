class role::directory_server {
  include ::profile::base_linux
  include ::profile::dns::client
  include ::profile::dns::server
  include ::profile::consul::server
}
