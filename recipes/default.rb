#
# Cookbook:: enginx
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
package 'nginx'
package 'curl'

service 'nginx' do
  action :start
end

# file '/var/www/html/index.nginx-debian.html' do
#     content "docker"
# end

template '/var/www/html/index.nginx-debian.html' do
  source 'index.nginx-debian.html.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  notifies :restart, 'service[nginx]', :immediately
end

directory '/etc/nginx/conf.d' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

template '/etc/nginx/conf.d/default.conf' do
  source 'default.conf.erb'
  notifies :restart, 'service[nginx]', :immediately
end
