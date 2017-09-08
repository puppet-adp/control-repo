#!/usr/bin/env ruby
require 'spec_helper_acceptance'
require 'beaker-pe'

describe 'Using Number::Zipcode type' do
  context 'Should compile with 12345' do
    describe 'success' do
      it 'should accept a 5-digit Integer' do
        pp = <<-EOS
        class foo (
          Number::Zipcode $foo,
        ) {
          notify { "$foo": }
        }
        class { 'foo': foo => 12345, }
        EOS

        apply_manifest(pp, :catch_failures => true) do |r|
          expect(r.stdout).to match(/Notice: 12345/)
        end
      end
    end
  end

  context 'Should fail with String' do
    describe 'failure' do
      it 'should not accept a String' do
        pp = <<-EOS
        class foo (
          Number::Zipcode $foo,
        ) {
          notify { "$foo": }
        }
        class { 'foo': foo => 'String', }
        EOS

        apply_manifest(pp, :expect_failures => true) do |r|
          expect(r.stderr).to match(/parameter 'foo' expects a Number::Zipcode/)
        end
      end
    end
  end
end
