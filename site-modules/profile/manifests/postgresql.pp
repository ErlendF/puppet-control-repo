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
}

