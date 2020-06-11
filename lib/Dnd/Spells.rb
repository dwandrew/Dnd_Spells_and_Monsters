require_relative '../environment.rb'

class Spells
    attr_reader :list, :count

def initialize
    spells= API.get_spells
    @list = spells["results"]
    @count = spells["count"]
end

# binding.pry

end