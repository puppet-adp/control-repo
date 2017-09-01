#! /usr/bin/env ruby -S rspec
require 'beaker-rspec'

control_repo_name = ENV['USERNAME'] ? "#{ENV['USERNAME']}-control-repo" : 'control-repo'

pe_opts = {
  :answers => {
    'console_admin_password'                                          => 'puppetlabs',
    'puppet_enterprise::puppet_master_host'                           => '%{::trusted.certname}',
    'puppet_enterprise::profile::master::code_manager_auto_configure' => true,
    'puppet_enterprise::profile::master::r10k_remote'                 => "https://github.com/puppet-adp/#{control_repo_name}",
  }
}
hosts.each do |host|

  if host['roles'].include?('master')
    install_pe_on(host, pe_opts)
  else
    install_puppet_agent_on(host)
  end
end
