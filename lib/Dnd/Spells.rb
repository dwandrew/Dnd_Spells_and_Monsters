require_relative '../environment.rb'

class Spells
    
    @@all =[]
    @@all_class =[]
    
def initialize
    spells= API.get_library("spells")
    spells["results"].each{|spell| @@all << API.get_url(spell['url'], "spells")}
    full_index_class
end

def self.index_list
    @@all_class.map.with_index(1) {|spell, index| "#{index}. #{spell.name}" }
end

def full_index_class
@@all.each{|spell| @@all_class << SingleSpell.new(spell)}
end

def self.all
    @@all
end

def self.all_class
    @@all_class
end

end
