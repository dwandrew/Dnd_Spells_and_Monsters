require_relative '../environment.rb'

class Monsters
    attr_accessor :list, :count

    @@all =[]

    def initialize
        mons= API.get_monsters
        @list = mons["results"]
        @count = mons["count"]
        full_index
    end

    def full_index
        @list.each{|mon| @@all << API.get_monster_url(mon['url'])}
    end


    def self.index_list
    array =[]
    @@all.each_with_index do |mon, index| array<< "#{index+1}. #{mon["name"]}" end
    array
    end
    
    def self.all
        @@all
    end

    def save
        @@all<<self
    end


    

end
# binding.pry
