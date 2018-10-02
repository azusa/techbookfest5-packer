#
# Cookbook Name:: man
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
package "man" do
	action :install
end

package "man-pages-ja" do
	action :install
end

