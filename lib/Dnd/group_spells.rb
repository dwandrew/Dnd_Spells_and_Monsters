require_relative '../environment.rb'

class GroupSpells

    def find_by_school(school)
        Spells.all_class.select {|spell| spell.school["name"] == school}
    end

    def find_by_level(level)
        Spells.all_class.select {|spell| spell.level == level.to_i}
    end
    def find_by_ritual
        Spells.all_class.select {|spell| spell.ritual}
    end

    def find_by_class(klass)
        selection =[]
        Spells.all_class.each do 
            |spell| spell.classes.each do |k| selection <<spell if k["name"] == klass
            end
        end
        selection
            
    end

end
