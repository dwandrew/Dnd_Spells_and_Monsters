require_relative '../environment.rb'

class API

@@url= "https://www.dnd5eapi.co/api/"

def self.get_spells
    uri = URI.parse("#{@@url}/spells/")
    response = Net::HTTP.get_response(uri)
    body = response.body
    JSON(body)
    # binding.pry
end


def self.get_single_spell(name)
    uri = URI.parse("#{@@url}/spells/#{name}")
    response = Net::HTTP.get_response(uri)
    body = response.body
    JSON(body)
    # binding.pry
end


end

API.get_single_spell("acid-arrow")
