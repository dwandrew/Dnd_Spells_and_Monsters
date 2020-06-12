require_relative '../environment.rb'

class Spells
    attr_reader :list, :count

    @@all =[]

def initialize
    spells= API.get_spells
    @list = spells["results"]
    @count = spells["count"]
    full_index
    save
end

def self.index_list
array =[]
@@all.each_with_index do |spell, index| array<< "#{index+1}. #{spell["name"]}" end
array
end

def full_index
@list.each{|spell| @@all << API.get_spell_url(spell['url'])}
end

def self.all
    @@all
end

def save
    @@all<<self
end

end

binding.pry