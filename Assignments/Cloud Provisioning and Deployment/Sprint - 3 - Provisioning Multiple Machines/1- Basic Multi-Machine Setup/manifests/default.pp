# execute apt-get update
	#exec { 'apt-get':
	#	command=> '/usr/bin/apt-get update && /usr/bin/sudo apt-get install -y curl git'
	#}
#I take this from the course blog
#if $ipaddress_eth1==undef {
# $myip=$ipaddress
#} else {
# $myip=$ipaddress_eth1
#}
 
#notify{"my ip ${myip}":}
 
#host {$hostname:
# ensure=>'present',
# target=>'/vagrant/hosts',
# ip=> $myip,
#}

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

	#package { 'nginx':
		
    	#	ensure  => 'installed'
	#}
	#exec { 'apt-get':
	#	command=> '/usr/bin/apt-get update && /etc/bin/apt-get install Nginx && sudo service nginx start'
	#}
	#service { "nginx":
    		#require => Exec['sudo /etc/init.d/nginx start'],
		#require => Package["nginx"],
    		#ensure => running,
    		#enable => true
	#}
	# Symlink /var/www/app on our guest with 
  	# host /path/to/vagrant/app on our system
  	#file { '/var/www/app':
    	#	ensure  => 'link',
    	#	target  => '/vagrant/app',
  	#}
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
###########

node 'tst0', 'tst1', 'tst2' {
	#I take this from the course blog
		#if $ipaddress_eth1==undef {
 			#$myip=$ipaddress
			#}		 else {
 			#	$myip=$ipaddress_eth1
			#}
 #
			#notify{"my ip ${myip}":}
 #
			#host {$hostname:
 			#ensure=>'present',
 			#target=>'/vagrant/hosts',
 			#ip=> $myip,
		#}
  
  	exec { 'apt-get':
		command=> '/usr/bin/apt-get update'
	}
}



