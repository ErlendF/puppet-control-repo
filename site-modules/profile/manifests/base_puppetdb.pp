#
# profile::base_puppetdb
#
class profile::base_puppetdb {

  $puppetdb_host = 'puppetdb.node.consul'
  $postgres_host = 'puppetdb.node.consul'

  # Here we install and configure PostgreSQL and the PuppetDB
  # database instance, and tell PostgreSQL that it should
  # listen for connections to the `$postgres_host`
  class { 'puppetdb::database::postgresql':
    listen_addresses => $postgres_host,
  }
  class { 'puppetdb::server':
    database_host => $puppetdb_host,
  }
}
