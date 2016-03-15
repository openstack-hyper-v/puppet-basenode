# == Class: basenode::etc_puppet
class basenode::etc_puppet ()inherits params {
  include basenode::params
  
  $puppet_master = hiera('puppet_master',{})
#    case $osfamily {
#      'RedHat':{ provider => 'rpm' }
#      'Debian':{ provider => 'apt' }
#      'Windows':{ provider => 'chocolatey'}
#      default:{ notify{'unknown provider':}}
#    }

  package {'puppet':
    ensure => latest,
  }

  case $::kernel {
    'Linux':{
      package {'librarian-puppet-maestrodev':
        ensure   => latest,
        provider => 'gem',
      }

      $roothome = '/root/'

      vcsrepo{'/etc/puppet/hiera':
        ensure   => latest,
        provider => git,
        source   => 'https://github.com/openstack-hyper-v/hiera.git',
      }

      vcsrepo{'/etc/puppet/manifests':
        ensure   => latest,
        provider => git,
        source   => 'https://github.com/openstack-hyper-v/puppet-manifests.git',
      }
      vcsrepo{'/etc/puppet/files':
        ensure   => latest,
        provider => git,
        source   => 'https://github.com/openstack-hyper-v/puppet-extra_Files.git',
      }
      vcsrepo{'/usr/local/src/Puppetfile-cambridge':
        ensure   => latest,
        provider => git,
        source   => 'https://github.com/openstack-hyper-v/Puppetfile-cambridge.git',
      }
    }
    'Windows':{
      Package { provider => 'chocolatey',}
      $roothome = 'C:\\Users\\Administrator\\'
    }
    default:{ notify{'we do not install puppet on you yet':}
    }
  }

# Begin Common Puppet config
#
##

  file {"${roothome}.gitconfig":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('basenode/gitconfig.erb'),
  }

  package {'puppet':
    ensure => latest,
  }

  class { 'puppet::agent':
    puppet_server => $puppet_master,
    environment   => production,
    splay         => true,
  }

}
