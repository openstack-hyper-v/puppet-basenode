# == Class: basenode::params
class basenode::params {
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $nfs_packages = [ 'portmap', 'nfs-common' ]
    }
    /(Red Hat|CentOS|Fedora)/: {
#     $nfs_packages = [
#       'nfs-utils',
#       'nfs-utils-lib',
#       'portmap',
#       'system-config-nfs' ]
      $nfs_packages = [ 'nfs-utils']
    }
    default:{
      warning("this isn't for ${::fqdn}")
    }
  }

}
