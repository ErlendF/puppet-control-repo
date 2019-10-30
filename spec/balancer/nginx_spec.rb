require 'spec_helper'

describe package('nginx') do
    it { should be_installed }
end

describe service('nginx') do
    it { should be_running }
end

describe port(80) do
    it { should be_listening.with('tcp') }
end

describe file('/etc/nginx/sites-available') do
    it { should be_directory }
end

# checks that web API is running
describe command('curl web.service.consul') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /Success!/ }
end

# checks that grafana is running
describe command('curl grafana.service.consul:8080') do 
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /Found/ }
end

# checks that the puppetboard is up and running
describe command('curl http://puppetdb.service.consul:5000') do 
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /Puppetboard/ }
end

#
# Below this line ensures that nginx is configured for all 
# the services consul has informed it of.
#

describe file('/etc/nginx/sites-available/iacprosjekt.ntnu.conf') do
    it { should be_file }
    it { should contain 'listen *:80' }
end

describe file('/etc/nginx/sites-available/consul.iacprosjekt.ntnu.conf') do
    it { should be_file }
    it { should contain 'listen *:80' }
end

describe file('/etc/nginx/sites-available/puppetdb.iacprosjekt.ntnu.conf') do
    it { should be_file }
    it { should contain 'listen *:80' }
end
