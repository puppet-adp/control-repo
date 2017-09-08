#!/usr/bin/env ruby
require 'spec_helper_acceptance'
require 'beaker-pe'

describe 'Calling myos fact' do
  context 'Fact should return proper info' do
    describe command('facter -p myos') do
      let(:pre_command) { 'puppet plugin download' }
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match /^centos\-7\-x64/ }
      its(:stdout) { should match /((\d+)\.){3}(\d+)$/ }
    end
  end
end
