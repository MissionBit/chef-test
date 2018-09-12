#!/bin/bash

if ! [ -x "/usr/local/bin/managedsoftwareupdate"]
	curl -L https://www.opscode.com/chef/install.sh | bash

	mkdir /etc/chef
	cp node.nuke.json /etc/chef/node.json
	cp solo.rb /etc/chef
	cp -r cookbooks /etc/chef
	cp -r roles /etc/chef
	cp run_chef.sh /usr/local/bin/

	run_chef.sh
fi

#Run Munki with role to re-install
defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL http://10.0.13.119/munki_repo/
/usr/local/bin/managedsoftwareupdate id=nuke