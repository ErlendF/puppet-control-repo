node default {
  notify { "Oops Default! I'm ${facts['hostname']}": }
}
node /lin\d?.node.consul/ {
#  class { 'os_hardening': }
  include ::role::web_server
}
node 'manager.node.consul' {
  include ::role::manager
}
node 'mon.node.consul'{
  include ::role::manager
}
node 'dir.node.consul' {
  include ::role::directory_server
}
node 'puppetdb.node.consul'{
  #include ::role::puppetdb
}
