# encoding: utf-8

require 'twitter'
require 'yaml'

module StealthFavs
  module Main extend self

    # put your authentication keys in ~/.credential.yml
    CredentialFile = File.expand_path('~') + '/.credential.yml'

    def config_twitter
      return @client if @client

      yaml = YAML.load(File.open(CredentialFile).read)
      @client ||= Twitter::Client.new(
        consumer_key: yaml['consumer_key'],
        consumer_secret: yaml['consumer_secret'],
        oauth_token: yaml['oauth_token'],
        oauth_token_secret: yaml['oauth_token_secret']
      )
    end

    private :config_twitter

    def cmd_id(id, verbose: true, count: 20, interval: 0.1)
      cl = config_twitter
      (1..count).each do |i|
        cl.favorite id
        puts "[#{i}] Favorited status #{id}" if verbose
        sleep interval
        cl.unfavorite id
        puts "[#{i}] Unfavorited status #{id}" if verbose
        sleep interval
      end
    rescue Twitter::Error::NotFound => e
      STDERR.puts "status is not found"
      raise e
    rescue => e
      cl.unfavorite id
      raise e
    end

    def cmd_user(name, verbose: true, count: 20, interval: 0.1)
      cl = config_twitter
      begin
        id = cl.user_timeline(name).first.id
        puts "A target status is #{id}." if verbose
      rescue Twitter::Error::NotFound => e
        STDERR.puts "user is not found"
        raise e
      end
      cmd_id id, verbose: verbose, count: count, interval: interval
    end

  end  # module Main
end  # module StealthFavs
