require 'spec_helper'

describe 'profile::haproxy', :type => :class do 

    let(:facts) { {
        :osfamily  => 'debian',
        :ipaddress => '127.0.0.1',
    } }

    it 'should include ::haproxy' do
        #is_expected.to contain_class('::haproxy') 
        is_expected.to contain__haproxy('')
    end

    it { is_expected.to compile }
    it { is_expected.to compile.with_all_deps }

end