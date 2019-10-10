#
# profile::golang
#


class profile::golang {
  class { 'golang':
    version   => '1.1.2',
    workspace => '/usr/local/src/go',
  }
}
