#
# profile::base_webserver
#
class profile::webserver::base_webserver {
  $repopath = lookup('webserver::base_webserver::repopath')
  $bindir = lookup('webserver::base_webserver::bindir')
  $apiname = lookup('webserver::base_webserver::apiname')

  notify { "Hi, I am ${module_name}": }

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

  include systemd::systemctl::daemon_reload

  file { '/usr/lib/systemd/system/web.service':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/${module_name}/web.service",
  }
  ~> Class['systemd::systemctl::daemon_reload']

  service {'foo':
    ensure    => 'running',
    subscribe => File['/usr/lib/systemd/system/web.service'],
  }
}
