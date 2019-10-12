#
# ::profile::base_postgresql
#
class profile::base_postgresql {
    class { 'postgresql::server':
    }

    postgresql::server::db { 'mydatabasename':
      user     => 'verycoolman',
      password => postgresql_password('erlenfon', 'sup3rsm4rt'),
    }
}

