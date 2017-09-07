#!/usr/bin/env ruby
require 'spec_helper_acceptance'
require 'beaker-pe'

describe service('puppet') do
  it { should be_enabled }
end

[4433, 8081, 8140].each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
