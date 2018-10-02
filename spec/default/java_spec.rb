require 'spec_helper'


describe command("/usr/java/default/bin/java -version") do
	its(:exit_status) { should eq 0 }
end


