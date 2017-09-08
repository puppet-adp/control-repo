#!/usr/bin/env ruby
require 'spec_helper_acceptance'
require 'beaker-pe'

describe 'Adding a new node group via API' do
  context 'Group should not exist already' do
    describe command('puppet node_manager groups \'New Group\' --render-as yaml') do
      its(:stdout) { should match /{}/ }
    end
  end

  context 'Script should run successfully' do
    describe command('/etc/puppetlabs/code/environments/production/scripts/add_group.sh') do
      its(:exit_status) { should eq 0 }
    end
  end

  context 'RAL should produce newly created group' do
    describe command('puppet node_manager groups \'New Group\' --render-as yaml') do
      its(:stdout) { should match /parent: 00000000-0000-4000-8000-000000000000/ }
      its(:stdout) { should match /name: New Group/ }
      its(:stdout) { should match /environment: production/ }
      its(:stdout) { should match /classes: {}/ }
    end
  end
end
