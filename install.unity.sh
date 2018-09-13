#!/bin/bash

curl -L https://www.opscode.com/chef/install.sh | bash

mkdir /etc/chef
cp node.unity.json /etc/chef/node.json
cp solo.rb /etc/chef
cp -r cookbooks /etc/chef
cp -r roles /etc/chef
cp run_chef.sh /usr/local/bin/

#test run
run_chef.sh
