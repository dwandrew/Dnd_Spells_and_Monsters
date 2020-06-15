require_relative '../environment.rb'

class Monsters < Spells

    def initialize
        spells= API.get_monsters
        @list = spells["results"]
        @count = spells["count"]
        full_index
    end

    def full_index
        @list.each{|spell| @@all << API.get_monster_url(spell['url'])}
    end

end
# binding.pry
