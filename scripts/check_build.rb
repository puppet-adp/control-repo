#!/usr/bin/env ruby
require 'net/http'
require 'json'
require 'uri'
require 'openssl'

class Build
  def initialize(username)
    @repo = "puppet-adp/#{username}-control-repo"

    res = travis_call("repos/#{@repo}")
    raise res.body unless res.code == '200'

    @build_id = JSON.parse(res.body)['repo']['last_build_id']
    res       = travis_call("repos/#{@repo}/builds/#{@build_id}")
    raise res.body unless res.code == '200'

    @job_id = JSON.parse(res.body)['build']['job_ids'].first
    res     = travis_call("jobs/#{@job_id}/log")

    if res.code == '307'
      headers = {
        'Host'       => 's3.amazonaws.com',
        'Connection' => 'keep-alive',
        'User-Agent' => 'Travis WhatsARanjit',
      }
      raw = do_https(res['Location'], '', headers)
      puts raw.body
    elsif res.code == '200'
      json = JSON.parse(res.body)
      puts json['log']['body']
    else
      raise res.body
    end
  end

  private

  def travis_call(endpoint)
    headers = {
      'User-Agent'   => 'Travis WhatsARanjit',
      'Host'         => 'api.travis-ci.org',
      'Content-Type' => 'application/json',
      'Accept'       => 'application/vnd.travis-ci.2+json',
    }
    do_https('https://api.travis-ci.org', endpoint, headers)
  end

  def do_https(api, endpoint, headers = {}, method = 'get', data = {})
    url  = endpoint == '' ? api : "#{api}/#{endpoint}"
    uri  = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req              = Object.const_get("Net::HTTP::#{method.capitalize}").new(uri.request_uri)
    req.body         = data.to_json
    req.content_type = 'application/json'

    headers.each do |h,v|
      req[h] = v
    end

    begin
      res = http.request(req)
    rescue Exception => e
      fail(e.message)
      debug(e.backtrace.inspect)
    else
      res
    end
  end

end

username = `grep USERNAME #{File.expand_path(File.dirname(__FILE__))}/../.travis.yml | cut -d "'" -f2`.chomp
b = Build.new(username)
