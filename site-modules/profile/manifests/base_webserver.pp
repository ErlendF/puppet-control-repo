#
# profile::base_webserver
#
class profile::base_webserver {
  $

  class { 'golang':
    version => '1.13.1',
  }

  vcsrepo { '/root/webserverRepo':
    ensure   => latest,
    provider => git,
    source   => 'git@bitbucket.org:ErlendFonnes/test-rest.git', #parameterize
  }

  exec { 'build':
    command => 'go build -i -o web main.go', #parameterize which file to build?
    path    => '/root/webserverRepo',
    require => [
      Class['golang'],
      Vcsrepo['/root/webserverRepo']
    ],
  }
  $settings = {
    'Unit' => {
      'Description' => 'Golang REST API',
      'After'       => 'network.target auditd.service',
    },
    'Service' => {
      #'EnvironmentFile' => ''
    }
  }
}
