#
# profile::base_webserver
#
class profile::base_webserver {
  $repopath = '/root/webserverRepo'
  $bindir ='web'
  $apiname = 'test'
  $golangworkspace = '/usr/local/go'

  class { 'golang':
    version   => '1.13.1',
    workspace => $golangworkspace,
  }

  package { 'git':
    ensure => latest,
  }

  file { "${repopath}/${bindir}":
    ensure => 'directory',
  }

  vcsrepo { $repopath:
    ensure   => latest,
    provider => git,
    source   => 'https://bitbucket.org/ErlendFonnes/test-rest.git', #parameterize
    require  => Package['git'],
  }

  exec { 'build':
    command => "cd ${repopath} && ${$golangworkspace}/bin/go build -i -o ${bindir} ./...", #parameterize which file to build?
    require => [
      File["${repopath}/${bindir}"],
      Class['golang'],
      Vcsrepo[$repopath]
    ],
  }

  $defaults = { 'path' => "/etc/systemd/system/${bindir}.service"}
  $settings = {
    'Unit'    => {
      'Description' => 'Golang REST API',
      'After'       => 'network.target auditd.service',
    },
    'Service' => {
      'ExecStart'                => "${repopath}/${bindir}/${apiname}",
      'ExecReload'               => "${repopath}/${bindir}/${apiname}",
      'KillMode'                 => 'process',
      'Restart'                  => 'always',
      'RestartPreventExitStatus' => '255',
      'Type'                     => 'simple',
    },
    'Install' => {
      'WantedBy' => 'multi-user.target',
    }
  }

  # file { "/etc/systemd/system/${bindir}.service":
  #   ensure => present,
  # }

  service {'webserver':
    ensure    => 'running',
    subscribe => create_ini_settings($settings, $defaults),
    require   => Exec['build'],
  }
}
