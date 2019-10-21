require 'spec_helper'

describe 'profile::haproxy', :type => :class do 

    let(:facts) { {
        :kernel => "Linux",
        :osfamily       => 'debian',
        :os => { :family => 'debian' },
        :ipaddress      => '127.0.0.1',
        :architecture   => 'amd64',
    } }

    it 'should include ::haproxy' do
        is_expected.to contain_class('haproxy')
    end

    it 'should have only 4 classes (::haproxy, profile::haproxy, haproxy::xxx & xxx)' do 
        is_expected.to have_class_count(4)
    end

    it { is_expected.to contain_haproxy__listen("balancer") }
    it { is_expected.to contain_haproxy__balancermember("lin0") }
    it { is_expected.to contain_haproxy__balancermember("lin1") }


    it { is_expected.to compile }
    it { is_expected.to compile.with_all_deps }

end