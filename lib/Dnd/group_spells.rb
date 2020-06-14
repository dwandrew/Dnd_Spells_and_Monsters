require_relative '../environment.rb'

class GroupSpells
    attr_reader :list

    def initialize
       @list = Spells.all
    end

    def spells_by_collection(collection)
        group = []
        collection.each do |spell| group << SingleSpell.new(spell["name"]) end
        group
    end

    def find_by_school(school)
        selection = []
        @list.each do 
            |spell| selection << spell if spell["school"]["name"] == school
        end
        selection
    end

    def find_by_level(level)
        selection = []
        @list.each do 
            |spell| selection << spell if spell["level"] == level.to_i
        end
        selection
    end

    def find_by_ritual
        selection = []
        @list.each do 
            |spell| selection << spell if spell["ritual"]
        end
        selection
    end

    def find_by_class(klass)
        selection = []
        @list.each do 
            |spell| spell["classes"].each do |k| selection << spell if k["name"] == klass
            end
        end
        selection
    end

    def spell_by_name(name)
        spell = SingleSpell.new(name)
        puts display_spell(spell)
    end

end

# binding.pry
