#!/bin/bash

curl -L https://www.opscode.com/chef/install.sh | bash

mkdir /etc/chef
cp node.json /etc/chef
cp solo.rb /etc/chef
cp -r cookbooks /etc/chef

#test run
chef-solo -c /etc/chef/solo.rb
