require_relative '../environment.rb'

class SingleMonster < SingleSpell
    attr_accessor :_id, :index, :name, :size, :type, :subtype, :alignment, :armor_class, :hit_points, :hit_dice, :speed, :other_speeds, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, :proficiencies, :damage_vulnerabilities, :damage_resistances, :damage_immunities, :condition_immunities, :senses, :languages, :challenge_rating, :special_abilities, :actions, :legendary_actions , :url, :reactions

    def initialize(name)
        list= Monsters.all
        monster = list.detect{|monster| monster["name"] == name}
        spell_attributes(monster)
        save
    end
end

# binding.pry