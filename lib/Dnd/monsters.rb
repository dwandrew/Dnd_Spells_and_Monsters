require_relative '../environment.rb'

class Monsters

    @@all =[]
    @@all_class =[]

    def initialize
        mons= API.get_library("monsters")
        bar = ProgressBar.new(mons["count"], :bar, :percentage)
        print bar
        mons["results"].each do |mon| 
            @@all << API.get_url(mon['url'], "monsters") 
            bar.increment!  
            end
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
