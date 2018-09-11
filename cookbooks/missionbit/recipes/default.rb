#
# Cookbook:: missionbit
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

bash 'run munki'  do
   code "defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL #{	node['cpe_munki']['preferences']['SoftwareRepoURL']} && /usr/local/munki/managedsoftwareupdate && /usr/local/munki/managedsoftwareupdate --installonly"
end


