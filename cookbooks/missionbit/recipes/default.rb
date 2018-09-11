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
end

#
# Install script to manage dock items, from
#   https://github.com/kcrawford/dockutil 
#
cookbook_file '/usr/loca/bin/dockutil' do 
  source 'dockutil'
  owner 'root'
  group 'wheel'
  mode  '0755'
  action :nothing
  subscribes :create, "bash[run munki]", :immediately
  notifies   :run, "bash[setup dock]", :immediately
end

bash 'setup dock' do
	code <<-EOF
		/usr/local/bin/dockutil --remove all
	EOF
	live_stream true
	action :nothing
end
