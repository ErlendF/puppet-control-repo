$puppetdb_host = 'mon.node.consul'
$postgres_host = 'mon.node.consul'


node default {
  notify { "Oops Default! I'm ${facts['hostname']}": }
}
node /lin\d?.node.consul/ {
#  class { 'os_hardening': }
  include ::role::web_server
}
node 'manager.node.consul' {
  include ::role::manager

  # Tell Puppet master to use PuppetDB and hostname of the PuppetDB node
  class { 'puppetdb::master::config':
  puppetdb_server => $puppetdb_host,
  }
}
node 'mon.node.consul'{
  include ::role::manager

  # Here we install and configure PostgreSQL and the PuppetDB
  # database instance, and tell PostgreSQL that it should
  # listen for connections to the `$postgres_host`
  class { 'puppetdb::database::postgresql':
    listen_addresses => $postgres_host,
  }
  class { 'puppetdb::server':
    database_host => $postgres_host,
  }
}
node 'dir.node.consul' {
  include ::role::directory_server
}

