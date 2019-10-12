#
# profile::base_puppetdb
#
class profile::base_puppetdb {

  $puppetdb_host = 'puppetdb.node.consul'
  $postgres_host = 'puppetdb.node.consul'

  # Here we install and configure PostgreSQL and the PuppetDB
  # database instance, and tell PostgreSQL that it should
  # listen for connections to the `$postgres_host`
  #lass { 'puppetdb':
  #  listen_addresses => $postgres_host,
  #  database_host    => $puppetdb_host,
  #}

  #class { 'puppetboard':
  #  manage_git        => true,
  #  manage_virtualenv => true,
  #}

}
