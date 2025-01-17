#
# ::profile::postgresql
# Sets up PostgreSQL on a server 
#
class profile::postgresql {

  $uname = lookup('postgresql::uname')
  $pass  = Sensitive(lookup('postgresql::pass'))
  $access_address = lookup('postgresql::access_address', undef, undef, '0.0.0.0/0')
  $dbname = lookup('postgresql::db_name', undef, undef, 'postgres')

  class { 'postgresql::server':
    listen_addresses        => '*',
    ip_mask_allow_all_users => '192.168.0.0/16'
  }

  #Adding a database to the postgres server
  postgresql::server::db { $dbname:
    user     => $uname,
    password => postgresql_password($uname, $pass.unwrap),
    require  => Class['postgresql::server']
  } #allowing the user access to the server remotely
  -> postgresql::server::pg_hba_rule { 'allow golang network to access app database':
    description => "Open up postgresql for access from ${access_address}",
    type        => 'host',
    database    => $dbname,
    user        => $uname,
    address     => $access_address,
    auth_method => 'md5',
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
