# execute apt-get update
exec { 'apt-get':
	command=> '/usr/bin/apt-get update && /usr/bin/sudo apt-get install -y curl git'
}



# execute the following command to install the correct version of node.js
exec { 'curl':
	command=> '/usr/bin/curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && sudo apt-get install -y nodejs'
}


