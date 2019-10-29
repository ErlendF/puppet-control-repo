require 'spec_helper'

describe file('/usr/local/go') do
    it { should exist }
    it { should be_directory }
end

describe command('/usr/local/go/bin/go version') do 
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match 'go version go1.13.3' }
end

# custom service for application
describe service('web') do
    it { should be_running }
end

describe file('/root/webserverRepo') do
    it { should be_directory }
end

describe port(80) do
    it { should be_listening }
end

describe port(443) do
    it { should_not be_listening }
end
