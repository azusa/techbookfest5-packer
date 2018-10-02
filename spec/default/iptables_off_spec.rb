require 'spec_helper'

describe service("iptables") do
	it { should_not be_enabled }
end

