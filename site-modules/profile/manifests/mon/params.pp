#
# profile::mon::params
# Params is used because the variables are needed in both telegraf.pp and grafanainflux.pp
class profile::mon::params (
  Sensitive $influxdb_password = lookup('mon::params::influxdb_password'),
  Sensitive $grafana_password = lookup('mon::params::grafana_password'),
  String $influxdb_database = lookup('mon::params::grafanauser'),
  String $influxdb_user = lookup('mon::params::grafanauser'),
  String $grafana_url = 'http://localhost:8080',
  String $grafana_user = lookup('mon::params::grafanauser'),
) {}
