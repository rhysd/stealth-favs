# encoding: utf-8

require 'twitter'
require 'yaml'

module StealthFavs
  module Main extend self

    def config_twitter
      yaml = YAML.load(File.open(Setting).read)
      @client ||= Twitter::Client.new(
        consumer_key: yaml['consumer_key'],
        consumer_secret: yaml['consumer_secret'],
        oauth_token: yaml['oauth_token'],
        oauth_token_secret: yaml['oauth_token_secret']
      )
    end

    def user(opts, name)
      p opts
      p name
    end
  end  # module Main
end  # module StealthFavs
