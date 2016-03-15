# == Class: basenode::dhcp2static
#
class basenode::dhcp2static {

  $iface1 = $::interface_type ? {
    /(eth)/ => 'eth0',
    /(em)/  => 'em1',
  }

  $iface2 = $::interface_type ? {
    /(eth)/ => 'eth1',
    /(em)/  => 'em2',
  }

  $iface3 = $::interface_type ? {
    /(eth)/ => 'eth2',
    /(em)/  => 'em3',
  }


  file {"/etc/sysconfig/network-scripts/ifcfg-${iface1}":
    ensure  => file,
    content => template('basenode/ifcfg-eth0.erb'),
  }
  file {"/etc/sysconfig/network-scripts/ifcfg-${iface2}":
    ensure  => file,
    content => template('basenode/ifcfg-eth1.erb'),
  }
  file {"/etc/sysconfig/network-scripts/ifcfg-${iface3}":
    ensure  => file,
    content => template('basenode/ifcfg-eth2.erb'),
  }


  file {'/etc/sysconfig/network':
    ensure  => file,
    content => template('basenode/network.erb'),
#    notify => service['network'],
  }

  file {'/etc/resolv.conf':
    ensure  => file,
#    notify => service['network'],
    content => ["
domain openstack.tld
search openstack.tld
nameserver 10.21.7.1
nameserver 10.21.7.2
"],


  }
  service { 'network':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
#    subscribe => File["/etc/sysconfig/network-scripts/ifcfg-${iface1}",
#                      "/etc/sysconfig/network-scripts/ifcfg-${iface2}",
#                      '/etc/sysconfig/network','/etc/resolv.conf'],
  }
}
#File["/etc/sysconfig/network-scripts/ifcfg-${iface1}"] ->
#  File["/etc/sysconfig/network-scripts/ifcfg-${iface2}"] ->
#    File['/etc/sysconfig/network']                         ->
#      Service['network']
