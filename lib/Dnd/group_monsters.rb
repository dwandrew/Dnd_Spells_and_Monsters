require_relative '../environment.rb'

class GroupMonsters
    attr_reader :list

    def initialize
       @list = Monsters.all
    end
 
     def find_by_type(type)
         selection = []
         @list.each do 
             |mons| selection << mon if mon["type"] == type
         end
         selection
     end
 
     def find_by_cr(cr)
         selection = []
         @list.each do 
             |mon| selection << mon if mon["challenge_rating"] == cr.to_f
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