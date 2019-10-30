require 'spec_helper'

describe service('grafana-server') do
    it { should be_running }
end
