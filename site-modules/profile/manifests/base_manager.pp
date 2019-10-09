#
# profile::base_manager
#


class profile::base_manager {
# users should be able to ssh without password to manager
  $ssh_key_johan = lookup('base_manager::ubuntu_ssh_key_johan')
  $ssh_key_erlend = lookup('base_manager::ubuntu_ssh_key_erlend')
  $ssh_key_aksel = lookup('base_manager::ubuntu_ssh_key_aksel')

  file { '/home/ubuntu/.ssh':
    ensure => 'directory',
    owner  => 'ubuntu',
    group  => 'ubuntu',
    mode   => '0700',
  }
  ssh_authorized_key { 'johan@manjaro':
    ensure => present,
    user   => 'ubuntu',
    type   => 'ssh-rsa',
    key    => $ssh_key_johan,
  }
  ssh_authorized_key { 'erlend@ubuntututu':
    ensure => present,
    user   => 'ubuntu',
    type   => 'ssh-rsa',
    key    => $ssh_key_erlend,
  }
  ssh_authorized_key { 'akselba@loginstud01':
    ensure => present,
    user   => 'ubuntu',
    type   => 'ssh-rsa',
    key    => $ssh_key_aksel,
  }
}

