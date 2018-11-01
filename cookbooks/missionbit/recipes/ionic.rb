
#
# Install ionic by calling NPM directly
# If we use this for more than a one-off we should 
# use the offical node cookbook and NPM packages
#

bash 'install ionic' do
	code "npm install -g ionic"
	live_stream true
	action :run
end

bash 'install cordova' do
	code "npm install -g cordova"
	live_stream true
	action :run
end

directory '/var/root/.android/' do 
  owner 'root'
  group 'wheel'
  mode '0755'
  action :create
end

file '/var/root/.android/repositories.cfg' do
	content ''
	mode 0644
	owner 'root'
	action :create_if_missing
end

#Note: Package files are broken in the current sdkmanager, when this is fixed we should
# provide a file for the packages we need to install instead of listing them out here.
bash 'install android SDK' do
	code "yes | sdkmanager \"sources;android-27\" \"platforms;android-27\" \"sources;android-25\" \"platforms;android-25\" \"build-tools;25.0.2\" \"sources;android-20\" \"platforms;android-20\" --sdk_root=/Users/missionbit/Library/Android/sdk/"
	environment 'PATH' => "/usr/local/android/tools/bin/:#{ENV['PATH']}"
	live_stream true
	action :run
end

bash 'disable android studio startup wizard' do
	code "echo 'disable.android.first.run=true' >>  '/Applications/Android\ Studio.app/Contents/bin/idea.properties'"
	not_if "grep 'disable\.android\.first\.run' '/Applications/Android\ Studio.app/Contents/bin/idea.properties'"
	live_stream true
	user 'root'
	action :run
end

cookbook_file '/Users/missionbit/.bash_profile' do
	source 'bash_profile'
	owner 'missionbit'
	group 'staff'
	mode '0644'
	action :create
end

bash 'source profile' do
	code "source /Users/missionbit/.bash_profile"
	action :run
end