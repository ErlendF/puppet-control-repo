require 'spec_helper'

describe service('influxdb') do
    it { should be_running }
end
