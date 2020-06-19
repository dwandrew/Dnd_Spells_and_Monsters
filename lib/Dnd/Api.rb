require_relative '../environment.rb'

class API

    @@url= "https://www.dnd5eapi.co/api/"

    def self.get_library(library)
        uri = URI.parse("#{@@url}#{library}/")
        response = Net::HTTP.get_response(uri)
        body = response.body
        JSON(body)
    end

    def self.get_url(url, library)
        url = url.gsub("/api/#{library}/", "")
        uri = URI.parse("#{@@url}/#{library}/#{url}")
        response = Net::HTTP.get_response(uri)
        body = response.body
        JSON(body)
    end

end

