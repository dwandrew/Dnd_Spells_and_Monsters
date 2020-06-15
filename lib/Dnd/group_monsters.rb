require_relative '../environment.rb'

class GroupMonsters
    attr_reader :list

    def initialize
       @list = Monsters.all
    end

end