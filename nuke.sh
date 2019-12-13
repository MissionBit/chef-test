#!/bin/bash

echo "💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣"
echo "💣 WARNING: "
echo "💣 This script will request a full re-install of OSX"
echo "💣 and DELETE YOUR HARD DISK CONTENTS"
echo "💣 Please press control+c in the next 20 seconds if "
echo "💣 you do not want to do this!!"
echo "💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣💣"

sleep 20

echo "Okay, let's take off and nuke it from orbit."

if ! [ -x "/usr/local/munki/managedsoftwareupdate" ] ; then
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
defaults write /Library/Preferences/ManagedInstalls InstallAppleSoftwareUpdates -bool True
defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL http://10.15.16.154/munki_repo/
/usr/local/munki/managedsoftwareupdate --id=nuke
/usr/local/munki/managedsoftwareupdate --id=nuke --installonly

#Now reboot for install
reboot