
# Cookbook Name:: web
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

directory "/opt/atlassian" do
	action :create
	owner "jira"
	group "atlassian"
	recursive true
end

directory "/var/atlassian/application-data" do
	action :create
	owner "jira"
	group "atlassian"
	recursive true
end


link "/opt/atlassian/jira" do
       to "/mnt/atlassian/jira/app"
end

link "/var/atlassian/application-data/jira" do
	to "/mnt/atlassian/jira/data"
end


VERSION="7.12.0"

ARCHIVE="atlassian-jira-#{node['jira']['type']}-#{VERSION}.tar.gz"

INSTALL_DIR="atlassian-jira-#{node['jira']['type']}-#{VERSION}-standalone"

file = "/opt/atlassian/jira/#{INSTALL_DIR}/bin/cataline.sh"
if not File.exists? file then
	remote_file "#{Chef::Config['file_cache_path']}/#{ARCHIVE}" do
	    action :create_if_missing
	    source "https://www.atlassian.com/software/jira/downloads/binary/#{ARCHIVE}"
	    notifies :run, 'bash[install]', :immediately
	end
end

bash 'install' do
	flags '-ex'
	cwd '/opt/atlassian/jira'
	user "jira"
	group "jira"
	code <<-EOH
tar xzf #{Chef::Config['file_cache_path']}/#{ARCHIVE}
	EOH
end

link "/opt/atlassian/jira/current" do
	to "/opt/atlassian/jira/#{INSTALL_DIR}"
end

directory "/mnt/atlassian/jira/data/log" do
	action :create
	owner "jira"
	group "jira"
	recursive true
end


directory "/mnt/atlassian/jira/data/log/app" do
	action :create
	owner "jira"
	group "jira"
	recursive true
end

directory "/opt/atlassian/jira/#{INSTALL_DIR}/logs" do
	action :delete
end


link "/opt/atlassian/jira/#{INSTALL_DIR}/logs" do
	to "/mnt/atlassian/jira/data/log/app"
end


file "/opt/atlassian/jira/current/logs/catalina.out" do
	action :nothing
end

package "bind-utils" do
	action :install
end

package 'nc' do
	action :install
end

template "/usr/local/bin/waitport" do
	owner "root"
	group "root"
	mode "0755"
end

template "/usr/local/bin/waitstop" do
	owner "root"
	group "root"
	mode "0755"
end

template "jira-application.properties" do
	path "/opt/atlassian/jira/#{INSTALL_DIR}/atlassian-jira/WEB-INF/classes/jira-application.properties"
	owner "root"
	group "root"
	mode "0644"
end

# unitの有効化はcustom cookbookの中で行う
template "jira.service" do
 	path"/etc/systemd/system/jira.service"
	owner "root"
	group "root"
	mode "0644"
end

template "jira.env" do
	path "/etc/systemd/system/jira.env"
	owner "root"
	group "root"
	mode "0644"
end


JDK_VERSION="8u181"

cookbook_file "#{Chef::Config[:file_cache_path]}/jdk-#{JDK_VERSION}-linux-x64.rpm" do
	source "jdk-#{JDK_VERSION}-linux-x64.rpm"
	action :create
end

rpm_package "jdk" do
	source "#{Chef::Config[:file_cache_path]}/jdk-#{JDK_VERSION}-linux-x64.rpm"
	action :install
end


package "dejavu-serif-fonts" do
	action :install
end

