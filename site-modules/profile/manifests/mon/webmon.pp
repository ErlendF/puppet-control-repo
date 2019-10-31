#
#profile::mon::webmon
#
class profile::mon::webmon () inherits profile::mon::telegraf {
  $servers = lookup('nginx::servers')

  # Attempted to import urls dynamically, similarly to how ssh_keys are imported in base_manager.
  # However, none of these methods seemed to function as intended, and the documentation was unclear, to say the least.
  # Therefore, the urls have been hardcoded for the time being, as it was not seen as a priority.


  # $servers_arr = Array[String]
  # $servers.each |Hash $server| {
  #   $server.each |String $name, String $address| {
  #     servers_arr << $address
  #   }
  # }

  # $servers.each |Hash $server_hash| {
  #   $server_hash.map |String $name, String $proxy| {
  #     $proxy
  #   }
  # }

  telegraf::input { 'http_check':
    plugin_type => 'http_response',
    options     => [
      {
        'method'           => 'GET',
        'follow_redirects' => true,
        'urls'             => [
          'http://puppetdb.service.consul:5000',
          'http://consul.service.consul:8500/',
          'http://web.service.consul/',
          'http://grafana.service.consul:8080/'
        ],
      },
    ]
  }
}
