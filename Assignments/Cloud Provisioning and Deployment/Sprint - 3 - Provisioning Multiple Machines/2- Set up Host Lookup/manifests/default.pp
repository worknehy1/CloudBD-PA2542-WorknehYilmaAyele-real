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

	#it can be deleted
	#host {
        #	'dbserver':
        #	ip => '192.168.56.5',
        #	host_aliases => 'dbserver',
        #	ensure => 'present',
	#	target=>'/etc/hosts',
     	#}
	
}
###############
node 'web' {

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

	#it can be deleted
	#host {
        #	'web':
        #	ip => '192.168.0.6',
        #	host_aliases => 'web',
        #	ensure => 'present',
	#	target=>'/etc/hosts',
     	#}
	
}
###########

node 'tst0', 'tst1', 'tst2' {
  
  	exec { 'apt-get':
		command=> '/usr/bin/apt-get update'
	}

	#it can be deleted - try to loop
	
	
}	

host {
        	'appserver':
        	ip => '192.168.0.5',
        	host_aliases => 'ApplicationServer',
        	ensure => 'present',
		target=>'/etc/hosts',
     	}
	host {
        	'dbserver':
        	ip => '192.168.0.6',
        	host_aliases => 'DatabaseServer',
        	ensure => 'present',
		target=>'/etc/hosts',
     	}
	host {
        	'web':
        	ip => '192.168.0.7',
        	host_aliases => 'WebServer',
        	ensure => 'present',
		target=>'/etc/hosts',
     	}
	host {
        	'tst0':
        	ip => '192.168.0.2',
        	host_aliases => 'TestServer_0',
        	ensure => 'present',
		target=>'/etc/hosts',
     	}
	host {
        	'tst1':
        	ip => '192.168.0.3',
        	host_aliases => 'TestServer_1',
        	ensure => 'present',
		target=>'/etc/hosts',
     	}
	host {
        	'tst2':
        	ip => '192.168.0.4',
        	host_aliases => 'TestServer_2',
        	ensure => 'present',
		target=>'/etc/hosts',
     	}




