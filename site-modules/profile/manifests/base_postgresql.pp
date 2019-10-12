#
# ::profile::base_postgresql
#
class profile::base_postgresql {
    class { 'postgresql::server':
    }

    postgresql::server::db { 'mydatabasename':
      user     => 'erlenfon',
      password => postgresql_password('erlenfon', 'sup3rsm4rt'),
    }
}

