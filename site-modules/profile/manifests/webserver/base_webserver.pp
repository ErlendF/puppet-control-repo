#
# profile::base_webserver
#
class profile::webserver::base_webserver {
  $repo_path = lookup('webserver::base_webserver::repo_path')
  $bin_dir = lookup('webserver::base_webserver::bin_dir')
  $api_name = lookup('webserver::base_webserver::api_name')
  $repo_url = lookup('webserver::base_webserver::repo_url')
  $service_name = lookup('webserver::base_webserver::service_name')

  class { 'golang':
    version   => '1.13.1',
  }

  package { 'git':
    ensure => latest,
  }

  file { "${repo_path}/${bin_dir}":
    ensure => 'directory',
  }

  vcsrepo { $repo_path:
    ensure   => latest,
    provider => git,
    source   => $repo_url,
    require  => Package['git'],
  }
  #TODO: make more idempotent
  exec { 'build':
    command     => "go build -i -o ${bin_dir} ./...",
    cwd         => $repo_path,
    path        => '/usr/local/go/bin',
    environment => ['GOPATH=/vagrant', 'HOME=/root'],
    require     => [
      File["${repo_path}/${bin_dir}"],
      Class['golang']
    ],
    subscribe   => Vcsrepo[$repo_path],
  }

  systemd::unit_file { 'web.service':
    source => "puppet:///modules/${module_name}/${service_name}.service",
  }
  ~> service { $service_name:
    ensure    => 'running',
    subscribe => Exec['build'],
  }
}
