
#
# Install ionic by calling NPM directly
# If we use this for more than a one-off we should 
# use the offical node cookbook and NPM packages
#

bash 'install ionic' do
	"npm install -g ionic"
	live_stream true
	action :run
end
