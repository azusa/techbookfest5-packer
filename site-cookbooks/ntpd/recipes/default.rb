#
# Cookbook Name:: openjdk
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
yum_package "chrony" do
	action :install
end


systemd_unit "chronyd" do
	enabled true
	active true
end



