# == Class: basenode::ipmitools
#
class basenode::ipmitools{

  package {'ipmitool':
    ensure => latest,
  }

  file {'/root/ipmi-tools':
    ensure  => directory,
    recurse => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    source  => 'puppet:///extra_files/ipmi-tools',
    require => Package['ipmitool'],
  }
}
