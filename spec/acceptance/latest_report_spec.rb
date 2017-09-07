#!/usr/bin/env ruby
require 'spec_helper_acceptance'
require 'beaker-pe'

describe 'Pulling latest reports via API' do
  context 'Script should run successfully' do
    describe command('/etc/puppetlabs/code/environments/production/scripts/latest_report.sh > /tmp/latest.json') do
      its(:exit_status) { should eq 0 }
    end
  end

  context 'Output should contain a Puppet report' do
    cmd_array = [
      'ruby -rjson -e',
      '"json = JSON.parse(File.read(\'/tmp/latest.json\')).first;',
      'if (json[\'certname\'] and json[\'catalog_uuid\']);',
      'puts json[\'certname\']; puts json[\'catalog_uuid\'];',
      'else; exit 1; end"'
    ]
    describe command(cmd_array.join(' ')) do
      its(:exit_status) { should eq 0 }
    end
  end
end

