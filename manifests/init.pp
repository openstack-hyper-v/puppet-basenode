# == Class: basenode::init
class basenode () inherits basenode::params {

  $ntp_servers   = hiera('ntp_servers',{})
  $puppet_master = hiera('puppet_master',{})
  $nfs_mounts    = hiera('nfs_mounts',{})
  $nfs_packages  = $params::nfs_packages

  notify {"Node: ${::hostname}":}

  # Set NTP
  class {'::ntp':
    servers => [ $ntp_servers ],
  }

  class { '::puppet::agent':
    puppet_server => $puppet_master,
    environment   => production,
    splay         => true,
  }

  if $::kernel == 'Linux' {
    package {$nfs_packages :
      ensure => latest,
    }

    package {['python-paramiko','python-netaddr']:
      ensure   => latest,
    }
    package {['screen','rsync']:
      ensure   => latest,
    }

#   class {'::basenode::pxefile':}
    class {'::basenode::sshkey_root':}

    create_resources(nfs_mounts,$nfs_mounts)

  }
#  if $osfamily == 'Redhat' {
#    exec {'update_yum':
#      command   => '/usr/bin/yum update -y --skip-broken', 
#      logoutput => true,
#    }
#  }
}
