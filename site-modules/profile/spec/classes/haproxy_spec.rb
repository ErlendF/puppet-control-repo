require 'spec_helper'

describe 'profile::haproxy' do 

    it 'should include ::haproxy' do

        it { is_expected.to contain__haproxy('') }

        it { is_expected.to compile }
        it { is_expected.to compile.with_all_deps }

    end

end