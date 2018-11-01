#
# Cookbook:: missionbit
# Recipe:: default
#
# Copyright:: 2018, MissionBit, All Rights Reserved.

#
# Run Munki to install apps
#
bash 'run munki'  do
   code "defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL #{	node['cpe_munki']['preferences']['SoftwareRepoURL']} && \
   /usr/local/munki/managedsoftwareupdate #{node['missionbit']['munki_args']} && \
   /usr/local/munki/managedsoftwareupdate #{node['missionbit']['munki_args']} --installonly"
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

dock_items=[
  "/Applications/Utilities/Terminal.app",
  "/Applications/Brackets.app",
  "/Applications/Sublime Text.app",
  "/Applications/Visual Studio Code.app",
  "/Applications/Google Chrome.app",
  "/Applications/Firefox.app",
  "/Applications/GitHub Desktop.app",
  '~/Downloads'
] + node['missionbit']['dock_extras']

dock_script = "/usr/local/bin/dockutil --remove all\n" + dock_items.collect{|i| "/usr/local/bin/dockutil --add \"#{i}\""}.join("\n")

bash 'setup dock' do
	code dock_script
	live_stream true
	action :run
end

#Enable firewall
bash 'enable firewall' do 
  code "/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on"
  live_stream true
  action :run
end