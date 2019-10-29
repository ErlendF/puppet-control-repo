class profile::mon::telegraf (
  String $password = $profile::mon::params::influxdb_password,
  String $database = $profile::mon::params::influxdb_database,
  String $username = $profile::mon::params::influxdb_user,
) inherits profile::mon::params {

  $influx_url = "http://${influx_host}:8086"
  $influx_host = ""
  class { 'telegraf':
    hostname => $facts['hostname'],
    outputs  => {
        'influxdb' => [
            {
                'urls'     => [ $influx_url ],
                'database' => $database,
                'username' => $username,
                'password' => $password,
            }
        ]
    },
  }

  telegraf::input{ 'cpu':
    options => [{ 'percpu' => true, 'totalcpu' => true, }]
  }

  ['disk', 'io', 'net', 'swap', 'system', 'mem', 'processes', 'kernel' ].each |$plug| {
    telegraf::input{ $plug:
      options => [{}]}
  }
}
