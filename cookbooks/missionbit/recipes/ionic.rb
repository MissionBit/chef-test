
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

file '/var/root/.android/repositories.cfg' do
	content ''
	mode 0644
	owner 'root'
	action :create_if_missing
end

bash 'install android SDK' do
	code "yes | sdkmanager \"platforms;android-27\" \"platforms;android-20\" --sdk_root=/Users/missionbit/Library/Android/sdk/"
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

