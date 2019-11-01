node default {
  notify { "Oops Default! I'm ${facts['hostname']}": }
}
node /lin\d?.node.consul/ {
  include ::role::web_server
}
node 'manager.node.consul' {
  include ::role::manager
}
node 'mon.node.consul'{
  include ::role::mon_server
}
node 'dir.node.consul' {
  include ::role::directory_server
}
node 'puppetdb.node.consul'{
  include ::role::puppetdbpuppetboard
}
node 'postgres.node.consul'{
  include ::role::postgres_server
}
node 'loadbalancer.node.consul'{
  include ::role::loadbalancer
}
