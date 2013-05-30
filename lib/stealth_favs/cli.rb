# encoding: utf-8

require 'thor'
require 'stealth_favs/main'

module StealthFavs

  class App < Thor
    private

    def self.def_command(name)
      define_method name do |*args|
        Main::__send__ "cmd_#{name}",options,*args
      end
    end

    def self.verbose_option
      method_option :verbose, :type => :boolean, :aliases => '-v', :default => true, :desc => 'output result'
    end

    public

    desc 'user [USER]', 'stealth favs to USER'
    verbose_option
    def_command :user

    desc 'id [STATUS ID]', 'stealth favs to STATUS'
    verbose_option
    def_command :id
  end

end  # module StealthFavs
