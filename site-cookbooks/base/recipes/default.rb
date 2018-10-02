#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute


systemd_unit "firewalld" do
	action [ :stop , :disable ]
end


group "atlassian" do
	gid 501
end

user "jira" do
	uid 501 
        home "/home/jira"
	manage_home true
	shell "/bin/bash"
end


bash 'update timezone' do
	flags '-eux'
	user "root"
	group "root"
	code <<-EOH
cp -f /usr/share/zoneinfo/Japan /etc/localtime
EOH
	not_if "diff /usr/share/zoneinfo/Japan /etc/localtime" 
end


bash "update timedatecrl" do
	code <<-EOH
timedatectl set-timezone Asia/Tokyo 
EOH
end

package "rsync" do
	action :install
end

bash 'disable selinux' do
        flags '-x'
        action :run
        code <<-EOH
sed -i -e s/SELINUX=enforcing/SELINUX=disabled/ /etc/selinux/config
sed -i -e s/SELINUX=permissive/SELINUX=disabled/ /etc/selinux/config
setenforce 0
exit 0
EOH
end

bash 'update locale' do
		action :run
		code <<-EOH
localectl set-locale LANG=ja_JP.UTF-8
EOH
end
