#!/usr/bin/env ruby
require 'spec_helper_acceptance'
require 'beaker-pe'

describe 'Using the sum() function' do
  it 'should add 2 Integers' do
    pp = <<-EOS
    $num = sum(10,15)
    notify { "$num": }
    EOS

    apply_manifest(pp, :catch_failures => true) do |r|
      expect(r.stdout).to match(/Notice: 25/)
    end
  end
end
