require 'spec_helper'

describe package('nginx') do
    it { should be_installed }
end

describe service('nginx') do
    it { should be_running }
end

describe port(80) do
    it { should be_listening }
end

describe file('/etc/nginx/sites-available') do
    it { should be_directory }
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

describe file('/etc/nginx/sites-available/sensu.iacprosjekt.ntnu.conf') do
    it { should be_file }
    it { should contain 'listen *:80' }
end