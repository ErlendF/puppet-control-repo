class profile::mon::params (
  String $influxdb_password = lookup('mon::params::influxdb_password'),
  String $grafana_password = lookup('mon::params::grafana_password'),
  String $influxdb_database = 'testdb',
  String $influxdb_user = 'testuser',
  String $grafana_url = 'https://mon.node.consul:8080',
  String $grafana_user = 'testuser',
) {}
