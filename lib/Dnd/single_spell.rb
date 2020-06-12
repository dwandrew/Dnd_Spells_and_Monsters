require_relative '../environment.rb'

class SingleSpell
attr_accessor :_id, :index, :name, :desc, :casting_time, :classes, :subclasses, :url, :level, :school, :higher_level, :range, :components, :ritual, :material, :duration, :concentration 

@@all = []

def initialize(name)
    spell = Spells.all.detect{|spell| spell["name"] == name}
    spell_attributes(spell)
    save
end

def spell_attributes(arguments)
arguments.each{|k, v| self.send(("#{k}="), v)}
end

def save
    @@all << self
end

def self.all
    @@all
end

def self.clear
    @@all.clear
end

end

# binding.pry
