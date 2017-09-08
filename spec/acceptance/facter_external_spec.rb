#!/usr/bin/env ruby
require 'spec_helper_acceptance'
require 'beaker-pe'

describe 'Calling myrole fact' do
  context 'Fact should return puppetlabs1234' do
    cmd_array = [
      'facter',
      '--external-dir /etc/puppetlabs/code/environments/production/modules/*/facts.d',
      '--external-dir /etc/puppetlabs/code/environments/production/site/*/facts.d',
      '--no-custom-facts',
      'myrole',
    ]
    describe command(cmd_array.join(' ')) do
      let(:pre_command) { 'puppet plugin download' }
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match /puppetlabs1234/ }
    end
  end
end
