define nfs_mounts($device,$options){

  mount_providers::do { $name:
    device => $device,
    options => $options,
    require => Package[$basenode::nfs_packages],
  }
  
  file {"${name}/hosts":
    ensure => directory,
    require => Mount_providers::Do[$name],
  }

  file {"${name}/hosts/${hostname}":
    ensure => directory,
    require => File["${name}/hosts"],
  }

  file {"${name}/hosts/${hostname}/dns.yaml":
    ensure => file,
#    content => template('ipam/dns_record.erb'),
    require => File["${name}/hosts/${hostname}"],
  }

  file {"${name}/hosts/${hostname}/dhcp.yaml":
    ensure => file,
#    content => template('ipam/static_ip.erb'),
    require => File["${name}/hosts/${hostname}"],
  }
  file {"${name}/hosts/${hostname}/interfaceinfo.yaml":
    ensure => file,
    content => template('basenode/interfaceinfo.erb'),
    require => File["${name}/hosts/${hostname}"],
  }


}
