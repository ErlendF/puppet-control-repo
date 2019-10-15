#
# profile::base_webserver
#
class profile::webserver::base_webserver {
  $repopath = lookup('webserver::base_webserver::repopath')
  $bindir = lookup('webserver::base_webserver::bindir')
  $apiname = lookup('webserver::base_webserver::apiname')

  class { 'golang':
    version   => '1.13.1',
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
    command     => "go build -i -o ${bindir} ./...", #parameterize which file to build?
    cwd         => $repopath,
    path        => '/usr/local/go/bin',
    environment => ['GOPATH=/vagrant', 'HOME=/root'],
    require     => [
      File["${repopath}/${bindir}"],
      Class['golang']
    ],
    subscribe   => Vcsrepo[$repopath],
  }

  ini_setting { 'ExecStart':
    ensure  => present,
    path    => "puppet:///modules/${module_name}/web.service",
    section => 'Service',
    setting => 'ExecStart',
    value   => "${repopath}/${bindir}/${apiname}",
  }

  ini_setting { 'ExecReload':
    ensure  => present,
    path    => "puppet:///modules/${module_name}/web.service",
    section => 'Service',
    setting => 'ExecReload',
    value   => "${repopath}/${bindir}/${apiname}",
  }

  systemd::unit_file { 'web.service':
    source  => "puppet:///modules/${module_name}/web.service",
    enable  => true,
    active  => true,
    require => [
      Ini_setting['ExecStart'],
      Ini_setting['ExecReload'],
    ],
  }
}
