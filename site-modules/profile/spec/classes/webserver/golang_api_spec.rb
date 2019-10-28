require 'spec_helper'

describe 'profile::webserver::golang_api' do

    test_on = {
        :hardwaremodels => ['x86_64'],
        :supported_os   => [
            {
                'operatingsystem'        => 'Ubuntu',
                'operatingsystemrelease' => '18.04',
            },
        ],
    }
    
    on_supported_os(test_on).each do |os, facts|
        let(:facts) do
            facts
        end

        let(:hiera_config) { 'spec/fixtures/hiera/hiera.yaml' }
        hiera = Hiera.new({:config => 'spec/fixtures/hiera/hiera.yaml'})

        it { is_expected.to compile }

    end
end