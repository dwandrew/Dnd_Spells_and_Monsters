require_relative '../environment.rb'

class SingleSpell
attr_accessor :_id, :index, :name, :desc, :casting_time, :classes, :subclasses, :url, :level, :school, :higher_level, :range, :components, :ritual, :material, :duration, :concentration 

    def initialize(spell)
        spell_attributes(spell)
    end

    def spell_attributes(arguments)
        arguments.each{|k, v| self.send(("#{k}="), v)}
    end

end
