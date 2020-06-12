require_relative '../environment.rb'

class GroupSpells

    def initialize
    end

    def self.find_by_school(school)
        selection = []
        Spells.all.each do 
            |spell| selection << spell if spell["school"]["name"] == school
        end
        selection
    end

    def self.find_by_level(level)
    end

    def self.find_by_ritual(ritual)
    end

    def self.find_by_class(klass)

    end

end
