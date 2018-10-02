require 'spec_helper'

describe service("jira") do
  it { should be_enabled }
  it { should be_running }
end

describe file("/var/atlassian/application-data/jira") do
	it { should be_directory }
	it { should be_writable.by('owner') }
end

describe file("/mnt/atlassian/jira/data") do
	it { should be_directory }
	it { should be_owned_by "jira" }
	it { should be_grouped_into "atlassian" }	
	it { should be_writable.by('owner') }
end

describe file("/opt/atlassian/jira") do
	it { should be_directory }
	it { should be_writable.by('owner') }
end

describe file("/mnt/atlassian/jira/app") do
	it { should be_directory }
	it { should be_owned_by "jira" }
	it { should be_grouped_into "atlassian" }	
	it { should be_writable.by('owner') }
end
describe file("/opt/atlassian/jira") do
	it { should be_linked_to "/mnt/atlassian/jira/app" }
end

describe file("/var/atlassian/application-data/jira") do
	it { should be_linked_to "/mnt/atlassian/jira/data" }
end

describe file("/opt/atlassian/jira/current/atlassian-jira/WEB-INF/classes/crowd.properties") do
	it { should be_file }
end
