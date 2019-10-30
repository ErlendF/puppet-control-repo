require 'spec_helper'

describe service('telegraf') do
    it { should be_running }
end
