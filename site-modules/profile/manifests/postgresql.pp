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
