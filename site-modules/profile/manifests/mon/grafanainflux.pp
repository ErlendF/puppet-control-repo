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
        host => 'mon.node.consul:3306',
        name => 'grafananana',
      },
    },
  }

  class {'influxdb': }

  influxdb::database{$influx_database:
    ensure         => present,
    admin_username => $influx_username,
    admin_password => $influx_password
  }


  grafana_datasource { 'influxdb':
    require          => Influx_database['testdb'],
    grafana_url      => $grafana_url,
    grafana_user     => $grafana_user,
    grafana_password => $grafana_password,
    type             => 'influxdb',
    url              => 'http://mon.node.consul:8086',
    user             => $influx_username,
    password         => $influx_password,
    database         => $influx_database,
    access_mode      => 'proxy',
    is_default       => true,
  }

  http_conn_validator { 'grafana-conn-validator' :
    host     => 'mon.node.consul',
    port     => '8080',
    use_ssl  => true,
    test_url => '/public/img/grafana_icon.svg',
    require  => Class['grafana'],
  }
  -> grafana_dashboard { 'telegraf':
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
}
