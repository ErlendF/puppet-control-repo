require 'spec_helper'

describe port(5432) do
    it { should be_listening }
end

describe service('apache2') do
    it { should be_running }
end