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
node 'appserver' {
  
	exec { 'curl':
		command=> '/usr/bin/sudo apt-get install -y curl git && /usr/bin/curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && sudo apt-get install -y nodejs'
	}
}





