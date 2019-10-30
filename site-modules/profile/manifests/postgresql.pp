#
# ::profile::postgresql
# Sets up PostgreSQL on a server 
#
class profile::postgresql {

  $uname = lookup('postgresql::uname')
  $pass  = lookup('postgresql::pass')
  $access_address = lookup('postgresql::access_address', undef, undef, '0.0.0.0/0')
  $dbname = lookup('postgresql::db_name', undef, undef, 'postgres')

  class { 'postgresql::server':
    listen_addresses        => '*',
    ip_mask_allow_all_users => '192.168.0.0/16'
  }

  postgresql::server::db { $dbname:
    user     => $uname,
    password => postgresql_password($uname, $pass),
    require  => Class['postgresql::server']
  }
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
