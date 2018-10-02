
# Cookbook Name:: web
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

template "hosts" do
	source 	["#{node.chef_environment}/hosts.erb"]
	path "/etc/hosts"
	owner "root"
	group "root"
    mode 0644
end

template "server.xml" do
	source 	["#{node.chef_environment}/server.xml.erb"]
	path "/opt/atlassian/jira/current/conf/server.xml"
	owner "jira"
	group "jira"
	mode 0755
end

template "setenv.sh" do
	source 	["#{node.chef_environment}/setenv.sh.erb"]
	path "/opt/atlassian/jira/current/bin/setenv.sh"
	owner "jira"
	group "jira"
	mode 0755
end

template "log4j.properties" do
	source 	["#{node.chef_environment}/log4j.properties.erb"]
	path "/opt/atlassian/jira/current/atlassian-jira/WEB-INF/classes/log4j.properties"
	owner "jira"
	group "jira"
	mode 0755
end

template "seraph-config.xml" do
	source 	["#{node.chef_environment}/seraph-config.xml.erb"]
	path "/opt/atlassian/jira/current/atlassian-jira/WEB-INF/classes/seraph-config.xml"
	owner "jira"
	group "jira"
	mode 0755
end

template "tomcat" do
	source 	["#{node.chef_environment}/tomcat.erb"]
	path "/etc/logrotate.d/tomcat"
	owner "root"
	group "root"
	mode 0644
end

template "jira.env" do
	source 	["#{node.chef_environment}/jira.env.erb"]
	path "/etc/systemd/system/jira.env"
	owner "root"
	group "root"
	mode "0644"
end

template "crowd.properties" do
	source 	["#{node.chef_environment}/crowd.properties.erb"]
	path "/opt/atlassian/jira/current/atlassian-jira/WEB-INF/classes/crowd.properties"
	owner "jira"
	group "jira"
	mode "0644"
end
