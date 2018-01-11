node 'appserver' {
  
	exec { 'curl':
		command=> '/usr/bin/sudo apt-get install -y curl git && /usr/bin/curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && sudo apt-get install -y nodejs'
	}
}
node 'dbserver' {
	exec { 'apt-get':
		command=> '/usr/bin/apt-get update'
	}
   	package { 'mysql-server':
    		ensure => installed,
  		}
	#the service name for mysql is mysql and not mysql-server - this is wrong
  	service { 'mysql':
    		ensure  => true,
    		enable  => true,
    		require => Package['mysql-server'],
		#root_password => "removed"
  		}
}
###############
node 'web' {

	# Install the nginx package. This relies on apt-get update
  	package { 'nginx':
		require => Package["nginx"], #Exec['apt-get update']],
    		ensure => Exec['apt-get update'],#'present',
    		#require => Exec['apt-get update'],
  	}

  	# Make sure that the nginx service is running
  	service { 'nginx':
    		ensure => running,
    		require => Package['nginx'],
  	}
}


node 'tst0', 'tst1', 'tst2' {
	  
  	exec { 'apt-get':
		command=> '/usr/bin/apt-get update'
	}
}



