
# Cookbook Name:: web
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#


systemd_unit "jira" do
	enabled true
	action [:reload, :enable, :start]
end

