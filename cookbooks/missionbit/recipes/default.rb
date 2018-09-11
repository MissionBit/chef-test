#
# Cookbook:: missionbit
# Recipe:: default
#
# Copyright:: 2018, MissionBit, All Rights Reserved.

#
# Run Munki to install apps
#
bash 'run munki'  do
   code "defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL #{	node['cpe_munki']['preferences']['SoftwareRepoURL']} && /usr/local/munki/managedsoftwareupdate && /usr/local/munki/managedsoftwareupdate --installonly"
   live_stream true
   #notifies   :run, "bash[setup dock]", :immediately
end

#
# Install script to manage dock items, from
#   https://github.com/kcrawford/dockutil 
#
cookbook_file '/usr/local/bin/dockutil' do 
  source 'dockutil'
  owner 'root'
  group 'wheel'
  mode  '0755'
  action :create
  #subscribes :create, "bash[run munki]", :immediately
  #notifies   :run, "bash[setup dock]", :immediately
end

bash 'setup dock' do
	code <<-EOF
		/usr/local/bin/dockutil --remove all
    /usr/local/bin/dockutil --add /Applications/Utilities/Terminal.app
    /usr/local/bin/dockutil --add /Applications/Brackets.app
    /usr/local/bin/dockutil --add "/Applications/Sublime Text.app"
    /usr/local/bin/dockutil --add "/Applications/Visual Studio Code.app"
    /usr/local/bin/dockutil --add "/Applications/Google Chrome.app"
    /usr/local/bin/dockutil --add /Applications/Firefox.app
    /usr/local/bin/dockutil --add "/Applications/GitHub Desktop.app"
    /usr/local/bin/dockutil --add '~/Downloads'

	EOF
	live_stream true
	action :run
end

