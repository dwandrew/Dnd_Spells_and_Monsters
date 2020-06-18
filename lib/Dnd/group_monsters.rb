require_relative '../environment.rb'

class GroupMonsters
    attr_reader :list

    def initialize
       @list = Monsters.all
    end

    # def mons_by_collection(collection)
    #     group = []
    #     collection.each do |mon| group << SingleMonster.new(mon["name"]) end
    #     group
    # end

    def find_by_attr(data, attr)
        Monsters.all_class.select {|mon| mon if mon[attr] == data}
    end
 
     def find_by_cr(cr)
        if cr == "1/8"
        cr = 0.125
        elsif cr == "1/4"
        cr = 0.25
        elsif cr =="1/2"
        cr = 0.5
        end
         Monsters.all_class.map do |mon|  mon if mon.challenge_rating == cr.to_f end
     end


end