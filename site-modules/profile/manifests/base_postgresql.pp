#
# ::profile::base_postgresql
#
class profile::base_postgresql {
    class { 'postgresql::server':
      ip_mask_deny_postgres_user => '0.0.0.0/32',
      ip_mask_allow_all_users    => '0.0.0.0/0',
      ipv4acls                   => ['hostssl all johndoe 192.168.0.0/24 cert'],
      postgres_password          => 'h3Sh3xd',
    }

    postgresql::server::db { 'mydatabasename':
      user     => 'erlenfon',
      password => postgresql_password('erlenfon', 'sup3rsm4rt'),
    }
}

