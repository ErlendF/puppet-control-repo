#
# ::profile::base_postgresql
# Sets up PostgreSQL on a server 
#
class profile::base_postgresql {

  $uname = lookup('base_postgresql::uname')
  $pass  = lookup('base_postgresql::pass')

  class { 'postgresql::server':
  }

  postgresql::server::db { 'goland':
    user     => $uname,
    password => postgresql_password($uname, $pass),
  }
}

