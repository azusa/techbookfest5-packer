require 'spec_helper'


describe command("date") do
    its(:stdout) { should contain "JST" }
end


describe command("timedatectl |grep \"Time zone\" |grep \"Asia/Tokyo\" ") do
	    its(:exit_status) { should eq 0 }
end


describe file("/etc/selinux/config") do
     its(:content) { should contain "SELINUX=disabled" }
end

describe command("getenforce") do
     its(:stdout) {
         pending "it fails before reboot."
         should contain "Disabled" 
     }
end
