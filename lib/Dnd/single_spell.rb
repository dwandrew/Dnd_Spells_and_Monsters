require_relative '../environment.rb'

class SingleSpell
attr_accessor :_id, :index, :name, :desc, :casting_time, :classes, :subclasses, :url, :level, :school, :higher_level, :range, :components, :ritual, :material, :duration, :concentration 

def initialize(name)
    spell = API.get_single_spell(name)
    spell_attributes(spell)
    # binding.pry
end

def spell_attributes(arguments)
arguments.each{|k, v| self.send(("#{k}="), v)}
end
  

end

binding.pry
