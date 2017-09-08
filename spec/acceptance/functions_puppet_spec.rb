#!/usr/bin/env ruby
require 'spec_helper_acceptance'
require 'beaker-pe'

describe 'Using the number::double() function' do
  it 'should double the given number' do
    pp = <<-EOS
    $num = number::double(10)
    notify { "$num": }
    EOS

    apply_manifest(pp, :catch_failures => true) do |r|
      expect(r.stdout).to match(/Notice: 20/)
    end
  end
end
