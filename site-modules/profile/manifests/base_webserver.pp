#
# profile::base_webserver
#
class profile::base_webserver {
  class { 'golang':
    version => '1.13.1',
  }

  vcsrepo { '/root/webserverRepo':
    ensure   => present,
    provider => git,
    source   => 'https://bitbucket.org/ErlendFonnes/test-rest/src/master/', #parameterize
  }

  exec { 'build':
    command => 'go build -i -o web main.go', #parameterize which file to build?
    path    => '/root/webserverRepo',
    require => [
      Class['golang'],
      Vcsrepo['/root/webserverRepo']
    ],
  }
}
