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

  file {"${repo_path}/${bin_dir}/hashfile":
    ensure => 'file',
  }

  vcsrepo { $repo_path:
    ensure   => latest,
    provider => git,
    source   => $repo_url,
    require  => Package['git'],
  }

  exec { 'build':
    command     => "go build -i -o ${bin_dir} ./... && git rev-parse HEAD > ${bin_dir}/hashfile",
    cwd         => $repo_path,
    path        => ['/usr/local/go/bin', '/usr/bin', '/bin'],
    environment => ['GOPATH=/vagrant', 'HOME=/root'],
    onlyif      => "[ ! -f ${bin_dir}/${api_name} ] || [ $(git rev-parse HEAD) != $(cat ${bin_dir}/hashfile) ]",
    require     => [
      File["${repo_path}/${bin_dir}"],
      Class['golang']
    ],
  }

  $service_config_hash = {
    'repo_path' => $repo_path,
    'bin_dir'   => $bin_dir,
    'api_name'  => $api_name,
  }

  systemd::unit_file { 'web.service':
    content => epp("${module_name}/web.service.epp", $service_config_hash),
  }
  ~> service { $service_name:
    ensure    => 'running',
    subscribe => Exec['build'],
  }
}
