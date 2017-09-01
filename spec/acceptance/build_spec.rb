require 'spec_helper_acceptance'
require 'beaker-pe'

describe service('puppet') do
  it { should be_enabled }
end
