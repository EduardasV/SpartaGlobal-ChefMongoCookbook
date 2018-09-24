#
# Cookbook:: mongo
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


apt_repository 'mongodb-org' do
  uri "http://repo.mongodb.org/apt/ubuntu"
  distribution 'xenial/mongodb-org/3.2'
  components ['multiverse']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'EA312927'
  action :add
end

apt_update 'update' do
  action :update
end

package 'mongodb-org' do
  action :upgrade
end

service 'mongod' do
  action [:enable, :start]
end

file '/etc/mongod.conf' do
  action :delete
  notifies(:restart, 'service[mongod]')
end

file '/lib/systemd/system/mongod.service' do
  action :delete
  notifies(:restart, 'service[mongod]')
end

template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  notifies(:restart, 'service[mongod]')
end

template '/lib/systemd/system/mongod.service' do
  source 'mongod.service.conf.erb'
  notifies(:restart, 'service[mongod]')
end
