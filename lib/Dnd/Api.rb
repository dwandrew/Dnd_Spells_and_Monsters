require_relative '../environment.rb'

class API

@@url= "https://www.dnd5eapi.co/api/"

def self.get_spells
    uri = URI.parse("#{@@url}/spells/")
    response = Net::HTTP.get_response(uri)
    body = response.body
    JSON(body)
   
end


def self.get_spell_url(url)
    url = url.gsub("/api/spells/", "")
    uri = URI.parse("#{@@url}/spells/#{url}")
    response = Net::HTTP.get_response(uri)
    body = response.body
    JSON(body)
end

end

# API.get_single_spell("acid-arrow")

# def self.get_spell_name(name)
#     uri = URI.parse("#{@@url}/spells/#{name}")
#     response = Net::HTTP.get_response(uri)
#     body = response.body
#     JSON(body)
    
# end

