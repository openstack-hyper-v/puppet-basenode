# == Class: basenode::sshkey_root
# SSH Keys and Authorized_Keys2 file

class basenode::sshkey_root {

  file { '/root/.ssh':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0600',
  }
  file { '/root/.ssh/id_dsa':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0600',
    source => 'puppet:///extra_files/id_dsa',
  }

  file { '/root/.ssh/id_dsa.pub':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0600',
    source => 'puppet:///extra_files/id_dsa.pub',
  }

  file { '/root/.ssh/authorized_keys':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0600',
    source  => 'puppet:///extra_files/id_dsa.pub',
    require => File[ '/root/.ssh' ],
  }
}

