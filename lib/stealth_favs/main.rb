# encoding: utf-8

require 'twitter'
require 'yaml'

module StealthFavs
  module Main extend self

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

    def cmd_id(opts, id, num_times = 20)
      cl = config_twitter
      begin
        (1..num_times).each do |i|
          cl.favorite id
          puts "[#{i}] Favorited status #{id}" if opts[:verbose]
          sleep 0.1
          cl.unfavorite id
          puts "[#{i}] Unfavorited status #{id}" if opts[:verbose]
          sleep 0.1
        end
      rescue Twitter::Error::NotFound
        STDERR.puts "status is not found"
      end
    end

    def cmd_user(opts, name, num_times = 20)
      cl = config_twitter
      begin
        id = cl.user_timeline(name).first.id
        puts "A target status is #{id}." if opts[:verbose]
      rescue Twitter::Error::NotFound
        STDERR.puts "user is not found"
      end
      cmd_id opts, id, num_times
    end

  end  # module Main
end  # module StealthFavs
