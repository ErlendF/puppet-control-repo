#
# profile::base_webserver
#
class profile::base_webserver {
  $repopath = '/root/webserverRepo'
  $binfile ='web'

  class { 'golang':
    version => '1.13.1',
  }

  package { 'git':
    ensure => latest,
  }

  vcsrepo { $repopath:
    ensure   => latest,
    provider => git,
    source   => 'https://bitbucket.org/ErlendFonnes/test-rest.git', #parameterize
    require  => Package['git'],
  }

  exec { 'build':
    command => "/usr/local/go/bin/go build -i -o ${binfile} main.go", #parameterize which file to build?
    path    => $repopath,
    require => [
      Class['golang'],
      Vcsrepo[$repopath]
    ],
  }

  $defaults = { 'path' => "/etc/systemd/system/${binfile}.service"}
  $settings = {
    'Unit'    => {
      'Description' => 'Golang REST API',
      'After'       => 'network.target auditd.service',
    },
    'Service' => {
      'ExecStart'                => "${repopath}/${binfile}",
      'ExecReload'               => "${repopath}/${binfile}",
      'KillMode'                 => 'process',
      'Restart'                  => 'always',
      'RestartPreventExitStatus' => '255',
      'Type'                     => 'simple',
    },
    'Install' => {
      'WantedBy' => 'multi-user.target',
    }
  }

  # file { "/etc/systemd/system/${binfile}.service":
  #   ensure => present,
  # }

  service {'webserver':
    ensure    => 'running',
    subscribe => create_ini_settings($settings, $defaults),
  }
}
