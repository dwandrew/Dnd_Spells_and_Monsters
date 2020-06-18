require_relative '../environment.rb'

class GroupMonsters

    def find_by_type(data)
        Monsters.all_class.select {|mon| mon if mon.type == data}
    end

    def find_by_size(data)
        Monsters.all_class.select {|mon| mon if mon.size == data}
    end
 
     def find_by_cr(cr)
        if cr == "1/8"
        cr = 0.125
        elsif cr == "1/4"
        cr = 0.25
        elsif cr =="1/2"
        cr = 0.5
        end
         Monsters.all_class.select {|mon| mon.challenge_rating == cr.to_f}
     end


end