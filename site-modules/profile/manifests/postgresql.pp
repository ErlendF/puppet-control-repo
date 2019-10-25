#
# ::profile::postgresql
# Sets up PostgreSQL on a server 
#
class profile::postgresql {

  $uname = lookup('postgresql::uname')
  $pass  = lookup('postgresql::pass')

  class { 'postgresql::server':
  }

  postgresql::server::db { 'goland':
    user     => $uname,
    password => postgresql_password($uname, $pass),
  }

  postgresql::server::pg_hba_rule { 'allow golang network to access app database':
    description => 'Open up postgresql for access from 192.168.0.0/16',
    type        => 'host',
    database    => 'postgres',
    user        => 'go',
    address     => '0.0.0.0/0', #for testing purposes
    # address     => '192.168.0.0/16',
    # auth_method => 'md5',
}

  consul::service { 'postgres':
  checks => [
    {
      tcp      => 'localhost:5432',
      interval => '10s',
    }
  ],
  port   => 5432,
  }
}
