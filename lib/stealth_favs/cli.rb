# encoding: utf-8

require 'thor'
require 'stealth_favs/main'

module StealthFavs

  class App < Thor
    private

    def self.def_command(name)
      define_method name do |*args|
        Main::__send__ name,options,*args
      end
    end

    public

    desc 'user [USER]', 'stealth favs to USER'
    def_command :user

    desc 'id [STATUS ID]', 'stealth favs to STATUS'
    def_command :id
  end

end  # module StealthFavs
