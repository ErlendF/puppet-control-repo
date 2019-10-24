#
# profile::webserver::golang_api
#  Pulls the golang REST API from the repo_url,
#  builds the repo to a single executables,
#  and manages the service running the application
class profile::webserver::golang_api {
  $api_name = lookup('webserver::golang_api::api_name')
  $repo_url = lookup('webserver::golang_api::repo_url')
  $repo_path = lookup('webserver::golang_api::repo_path', undef, undef, '/root/webserverRepo')
  $bin_dir = lookup('webserver::golang_api::bin_dir', undef, undef, 'web')
  $api_flags = lookup('webserver::golang_api::api_flags', undef, undef, '')
  $api_port = lookup('webserver::golang_api::api_port', undef, undef, 80) #port is handled seperately from other api flags
  $service_name = lookup('webserver::golang_api::service_name', undef, undef, 'web')
  $description = lookup('webserver::golang_api::description', undef, undef, 'My Golang REST API')
  $environment_file = lookup('webserver::golang_api::environment_file', undef, undef, '')
  $environment_variables = lookup('webserver::golang_api::environment_variables', undef, undef, [])

  notify { "Env vars: ${environment_variables}": }

  class { 'golang':
    version   => '1.13.1',
  }

  package { 'git':
    ensure => latest,
  }

  vcsrepo { $repo_path:
    ensure   => latest,
    provider => git,
    source   => $repo_url,
    require  => Package['git'],
  }

  file { "${repo_path}/${bin_dir}":
    ensure  => 'directory',
    require => Vcsrepo[$repo_path],
  }

  file { "${repo_path}/${bin_dir}/hashfile":
    ensure  => 'file',
    require => File["${repo_path}/${bin_dir}"],
  }
  if $environment_file != '' {
    $env_vars = {
      'envvars' => $environment_variables,
    }

    File { "${repo_path}/${environment_file}":
      ensure  => file,
      content => epp("${module_name}/env.epp", $env_vars),
      require => Vcsrepo[$repo_path],
    }
  }
  #Exec['build'] only runs if:
  # 1. the executable file is missing
  # 2. the hashfile containing the commithash is missing
  # 3. the commithash stored in the hashfile is not equal to latest
  #Thus, the exec is idempotent, only running when a change has occured, or system has deviated from expected state
  exec { 'build':
    command     => "go build -i -o ${bin_dir} ./... && git rev-parse HEAD > ${bin_dir}/hashfile",
    cwd         => $repo_path,
    path        => ['/usr/local/go/bin', '/usr/bin', '/bin'],
    environment => ['GOPATH=/vagrant', 'HOME=/root'],
    onlyif      => "[ ! -f ${bin_dir}/${api_name} ] || [ \"$(git rev-parse HEAD)\" != \"$(cat ${bin_dir}/hashfile)\" ]",
    require     => [
      File["${repo_path}/${bin_dir}/hashfile"],
      Class['golang']
    ],
  }

  $service_config_hash = {
    'repo_path'        => $repo_path,
    'bin_dir'          => $bin_dir,
    'api_name'         => $api_name,
    'api_flags'        => $api_flags,
    'api_port'         => $api_port,
    'description'      => $description,
    'environment_file' => "${repo_path}/${environment_file}",
  }

  systemd::unit_file { "${service_name}.service":
    content => epp("${module_name}/web.service.epp", $service_config_hash),
  }
  ~> service { $service_name:
    ensure    => 'running',
    subscribe => Exec['build'],
  }
  ~> consul::service { $service_name:
  checks => [
    {
      tcp      => "localhost:${api_port}",
      interval => '10s',
    }
  ],
  port   => $api_port,
  }
}
