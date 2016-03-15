# == Class: basenode::pxefile
#
define basenode::pxefile {
  $arp_type         = '01'
  #$host_macaddress = regsubst($::macaddress, '(\:)','(\-)','G')
  $host_macaddress  = regsubst($::macaddress, '(\:)','-','G')

  file {"//${::hostname}/${arp_type}-${host_macaddress}":
    ensure  => file,
    content => template('basenode/pxefile.erb'),
    require => File["/nfs/hosts/${::hostname}"],
  }

}
