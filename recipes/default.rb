#
# Cookbook Name:: openntpd
# Recipe:: default
#
# Copyright (c) 2015 Christopher Dickey, Licensed under the GNU GPLv2 
include_recipe "tar"
include_recipe "build-essential"

# Download OpenNtpd source tarball
#remote_file "#{Chef::Config[:file_cache_path]}/openntpd.tgz" do
#  source "#{node.default['openntpd']['download_url']}/openntpd-#{node.default['openntpd']['version']}.tar.gz"
#end

#tar_extract "#{Chef::Config[:file_cache_path]}/openntpd.tgz" do
tar_extract "#{node.default['openntpd']['download_url']}/openntpd-#{node.default['openntpd']['version']}.tar.gz" do
  target_dir node.default['openntpd']['source_dir']
  creates "#{node.default['openntpd']['source_dir']}/openntpd-#{node.default['openntpd']['version']}"
end

bash "compile_openntpd" do
  user "root"
  cwd "#{node.default['openntpd']['source_dir']}/openntpd-#{node.default['openntpd']['version']}"
  code <<-EOH
  ./configure && \
  make && \
  make install
  EOH
end

group "_ntp"

user "_ntp" do
  gid "_ntp"
  home "/var/empty/ntpd"
  shell "/sbin/nologin"
  system true
  supports :manage_home => true 
end

directory "/var/empty/ntpd" do
  owner "root"
  group "root"
  mode "0755"
end

# Generate the template
template "ntpd.conf" do
  owner "root"
  group "root"
  mode "0644"
  path "/usr/local/etc/ntpd.conf"
  source "ntpd.conf.erb"
end

cookbook_file "openntpd.init" do
  path "/etc/init.d/openntpd"
  owner "root"
  group "root"
  mode "0750"
  action :create
end

log "above_listen_message" do
  message "Above listen message"
  level :info
end

node.default['openntpd']['config']['listen_addresses'].each {|listen_address| 
  log "listen_message" do
    message "listen on #{listen_address}"
    level :info
  end
}

service "openntpd" do
  action [ :enable, :start]
end
