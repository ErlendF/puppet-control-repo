#
# ::profile::base_postgresql
#
class profile::base_postgresql {
    class { 'postgresql::server':
    }

    postgresql::server::db { 'goland':
      user     => 'go',
      password => postgresql_password('go', 'land'),
    }
}

