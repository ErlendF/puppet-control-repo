#
#profile::mon::webmon
#
class profile::mon::webmon () inherits profile::mon::telegraf {
  $nginx_servers = lookup('nginx::servers')
  # $servers_arr = []
  # $nginx_servers.each |Hash $server| {
  #   $server.each |String $name, String $address| {
  #     servers_arr << $address
  #   }
  # }

  telegraf::inputs { 'http_check':
    plugin_type => 'http_response',
    options     => {
      'interval'         => '60s',
      'method'           => 'GET',
      'follow_redirects' => true,
      'urls'             => 'http://puppetdb.service.consul:5000'
      #[
        # $nginx_servers['puppetdb.iacprosjekt.ntnu'],
        # $nginx_servers['consul.iacprosjekt.ntnu'],
        # $nginx_servers['iacprosjekt.ntnu'],
        # $nginx_servers['grafana.iacprosjekt.ntnu']
      #],
    },
  }
}
