require 'puppetlabs_spec_helper/module_spec_helper'
#require 'rspec-puppet-facts'

#require 'spec_helper_local' if File.file?(File.join(File.dirname(__FILE__), 'spec_helper_local.rb'))

#include RspecPuppetFacts

#default_facts = {
#  puppetversion: Puppet.version,
#  facterversion: Facter.version,
#}

#RSpec.configure do |c|
#  c.before :each do
#    # set to strictest setting for testing
#    # by default Puppet runs at warning level
#    Puppet.settings[:strict] = :warning
#  end
#  c.filter_run_excluding(bolt: true) unless ENV['GEM_BOLT']
#  c.after(:suite) do
#  end
#end

# Ensures that a module is defined
# @param module_name Name of the module
#def ensure_module_defined(module_name)
#  module_name.split('::').reduce(Object) do |last_module, next_module|
#    last_module.const_set(next_module, Module.new) unless last_module.const_defined?(next_module, false)
#    last_module.const_get(next_module, false)
#  end
#end

# 'spec_overrides' from sync.yml will appear below this line
