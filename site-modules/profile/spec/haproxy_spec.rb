require 'spec_helper'

describe 'profile::haproxy' do 


    it 'should include ::haproxy' do
        is_expected.to contain__haproxy('') 
    end

    it { is_expected.to compile }
    it { is_expected.to compile.with_all_deps }

end