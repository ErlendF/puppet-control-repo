require 'spec_helper'

describe 'profile::haproxy', :type => :class do 

    let(:facts) { {
        :kernel => "Linux",
        :osfamily       => 'debian',
        :os => { 
            :family => 'debian',
            :name   => 'Ubuntu' ,
        },
        :ipaddress      => '127.0.0.1',
        :architecture   => 'amd64',
        :path           => 'FIXME',
    } }

    it { is_expected.to compile }
    it { is_expected.to compile.with_all_deps }

end