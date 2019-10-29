require 'spec_helper'

#
# Should test if database exists & is reachable
#

describe service('postgresql') do
    it { should be_running }
end

describe port(5432) do
    it { should be_listening }
end