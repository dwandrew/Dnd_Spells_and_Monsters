require_relative '../environment.rb'

class GroupMonsters
    attr_reader :list

    def initialize
       @list = Monsters.all
    end

    def mons_by_collection(collection)
        group = []
        collection.each do |mon| group << SingleMonster.new(mon["name"]) end
        group
    end
 
     def find_by_type(type)
         selection = []
         @list.each do 
             |mon| selection << mon if mon["type"] == type
         end
         selection
     end

     def find_by_size(size)
        selection = []
        @list.each do 
            |mon| selection << mon if mon["size"] == size
        end
        selection
    end

     def find_by_cr(cr)
        if cr == "1/8"
        cr = 0.125
        elsif cr == "1/4"
        cr = 0.25
        elsif cr =="1/2"
        cr = 0.5
        end
         selection = []
         @list.each do 
             |mon| selection << mon if mon["challenge_rating"] == cr.to_f
         end
         selection
     end

end