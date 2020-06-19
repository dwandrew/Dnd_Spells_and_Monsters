require_relative '../environment.rb'

class Monsters

    @@all =[]
    @@all_class =[]

    def initialize
        mons= API.get_library("monsters")
        mons["results"].each{|mon| @@all << API.get_url(mon['url'], "monsters")}
        full_index_class
    end

    def full_index_class
        @@all.each{|monster| @@all_class << SingleMonster.new(monster)}
    end

    def self.index_list
        @@all_class.map.with_index(1) do |mon, index| "#{index}. #{mon.name}" end
    end
    
    def self.all
        @@all
    end

    def self.all_class
        @@all_class
    end

end
