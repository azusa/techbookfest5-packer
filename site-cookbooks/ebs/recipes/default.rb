
# Cookbook Name:: web
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
mount_point_app = "/mnt/atlassian/jira/app"
mount_point_data = "/mnt/atlassian/jira/data"

 
directory mount_point_app do
  action :create
  mode 000755
  owner "jira"
  group "atlassian"
  recursive true
end
 
directory mount_point_data do
  action :create
  mode 000755
  owner "jira"
  group "atlassian"
  recursive true
end

bash "chown directory" do
  code <<-EOH
    chown jira:atlassian #{mount_point_app}
    chown jira:atlassian #{mount_point_data}
EOH
end

template "user-data.sh" do
  path "/usr/local/bin/user-data.sh"
  owner "root"
  group "root"
  mode "0755"
end