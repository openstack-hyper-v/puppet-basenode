#
# basenode::users
#
# Description:
#    The basenode_user class performs the following tasks:
#    - Remove the user account created during the basenode
#      provisioning process. This accuount is named avter
#      the Linux distribution.  For example: Ubuntu
#
#    - Create a user account for the Jenkins slave.  
#      We will use the name 'jenkins-slave'
#
#    - Give the root account an SSH key to allow us to
#      send commands to the host to finish configuring the
#      host.
#

class basenode::remove_users {
  notify { 'xyz':
    message => "OS = ${::operatingsystem}",
  }

  #
  # Remove the legacy user created during the provisioning process.
  # The username will be the name of the OS: Ubuntu, CentOS, ...
  #
  user { $::operatingsystem:
    ensure => absent,
  }

  file { "/home/${::operatingsystem}":
    ensure    => absent,
    force     => true,
    subscribe => User[$::operatingsystem],
  }

}

