#
# profile::mon::grafanainflux
# 

class profile::mon::grafanainflux (
  String $grafana_password = $profile::mon::params::grafana_password,
  String $grafana_user = $profile::mon::params::grafana_user,
  String $grafana_url = $profile::mon::params::grafana_url,
  String $influx_password = $profile::mon::params::influxdb_password,
  String $influx_database = $profile::mon::params::influxdb_database,
  String $influx_username = $profile::mon::params::influxdb_user,

) inherits profile::mon::params {

  package { 'influxdb-client':
    ensure => latest,
  }

  class { 'grafana':
    cfg => {
      app_mode => 'production',
      server   => {
        http_port     => 8080,
      },
      security => {
        admin_user     => $grafana_user,
        admin_password => $grafana_password,
      },
      database => {
        type => 'sqlite3',
        host => '127.0.0.1:3306',
        name => 'grafananana',
      },
    },
  }

  grafana_user { $grafana_user:
    grafana_url      => $grafana_url,
    grafana_api_path => '/grafana/api',
    grafana_user     => $grafana_user,
    grafana_password => $grafana_password,
    full_name        => 'John Doe',
    email            => 'john@example.com',
    is_admin         => true
  }

  class {'influxdb': }

  influxdb::database{$influx_database:
    ensure         => present,
    admin_username => $influx_username,
    admin_password => $influx_password
  }

  grafana_datasource { 'influxdb':
    grafana_url      => $grafana_url,
    grafana_user     => $grafana_user,
    grafana_password => $grafana_password,
    basic_auth       => true
    type             => 'influxdb',
    url              => 'http://mon.node.consul:8086',
    user             => $influx_username,
    password         => $influx_password,
    database         => $influx_database,
    access_mode      => 'proxy',
    is_default       => true,
  }


  grafana_dashboard { 'telegraf':
    grafana_url      => $grafana_url,
    grafana_user     => $grafana_user,
    grafana_password => $grafana_password,
    content          => template("${module_name}/telegraf.json")
  }

  consul::service { 'influx':
    checks => [
      {
        tcp      => 'localhost:8086',
        interval => '10s',
      }
    ],
    port   => 8086,
  }

  consul::service { 'grafana':
    checks => [
      {
        tcp      => 'localhost:8080',
        interval => '10s',
      }
    ],
    port   => 8080,
  }
}
