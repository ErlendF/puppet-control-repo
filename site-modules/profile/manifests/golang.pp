#
# profile::golang
#
class profile::golang {
  class { 'golang':
    version => '1.13.1',
  }
}
