# encoding: utf-8

require 'thor'
require 'stealth_favs/main'
require 'active_record'

module StealthFavs

  class App < Thor
    private

    def self.def_command(name)
      define_method name do |*args|
        Main::__send__ "cmd_#{name}",*args,options.to_hash.symbolize_keys
      end
    end

    def self.verbose_option
      method_option :verbose, :type => :boolean, :aliases => '-v', :default => true, :desc => 'output result'
    end

    def self.id_option
      method_option :count, :type => :numeric, :aliases => '-c', :default => 20, :desc => 'number of favs'
    end

    def self.interval_option
      method_option :interval, :type => :numeric, :aliases => '-i', :default => 0.1, :desc => 'interval of favs [sec]'
    end

    public

    desc 'user [USER]', 'stealth favs to USER'
    verbose_option
    id_option
    interval_option
    def_command :user

    desc 'id [STATUS ID]', 'stealth favs to STATUS'
    verbose_option
    id_option
    interval_option
    def_command :id
  end

end  # module StealthFavs
