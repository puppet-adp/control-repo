source ENV['GEM_SOURCE'] || 'https://rubygems.org'

def location_from_env(env, default_location = [])
  if location = ENV[env]
    if location =~ /^((?:git|https?)[:@][^#]*)#(.*)/
      [{ :git => $1, :branch => $2, :require => false }]
    elsif location =~ /^file:\/\/(.*)/
      ['>= 0', { :path => File.expand_path($1), :require => false }]
    else
      [location, { :require => false }]
    end
  else
    default_location
  end
end

gem 'puppet', *location_from_env('PUPPET_GEM_VERSION')
gem 'facter', *location_from_env('FACTER_GEM_VERSION')
gem 'puppetlabs_spec_helper', '~> 2.3', '>= 2.3.2'
gem 'bundler', '~> 1.15', '>= 1.15.4'
gem 'vagrant', '~> 1.5'

# https://rubygems.org/gems/beaker-rspec/versions/6.1.0
gem 'beaker-rspec', '6.1.0'
gem 'beaker', '~> 3.0'
gem 'rspec', '~> 3.0'
gem 'serverspec', '~> 2'
gem 'specinfra', '~> 2'

# https://rubygems.org/gems/puppetlabs_spec_helper/versions/2.3.2
gem 'mocha', '~> 1.0'
gem 'puppet-lint', '~> 2.0'
gem 'puppet-syntax', '~> 2.0'
gem 'rspec-puppet', '~> 2.0'

# https://rubygems.org/gems/beaker-pe
gem 'beaker-pe', '1.22.0'
gem 'beaker-answers', '~> 0.0'
gem 'stringify-hash', '~> 0.0.0'
