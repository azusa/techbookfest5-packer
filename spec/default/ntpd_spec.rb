require 'spec_helper'

describe service("chronyd") do
  it { should be_enabled }
  it { should be_running }
end
