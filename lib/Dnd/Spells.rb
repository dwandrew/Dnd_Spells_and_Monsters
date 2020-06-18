require_relative '../environment.rb'

class Spells
    attr_reader :list, :count, :_id, :index, :name, :desc, :casting_time, :classes, :subclasses, :url, :level, :school, :higher_level, :range, :components, :ritual, :material, :duration, :concentration 

    @@all =[]
    @@all_class =[]
    
def initialize
    spells= API.get_spells
    @list = spells["results"]
    @count = spells["count"]
    full_index_hash
    full_index_class
end

def self.index_list
    @@all_class.map.with_index(1) {|spell, index| "#{index}. #{spell.name}" }
end

def full_index_hash
@list.each{|spell| @@all << API.get_spell_url(spell['url'])}
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

# def save
#     @@all<<self
# end

end

#  binding.pry