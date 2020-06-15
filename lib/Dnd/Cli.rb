require_relative '../environment'

class Cli
    attr_reader :list

    def initialize
        puts "Welcome to the Dnd 5th Edition Spellbook!"
        @list = {monsters: [], spells: []}
        main_menu
    end

    def main_menu
        puts "Would you like to load Monsterbook or Spellbook?"
        puts "Input 'Monsters' or 'Spells'"
        input = gets.strip
        if input.downcase == "monsters"
        puts "Loading Monsters list, it may take a few minutes"
            if Monsters.all == []
                Monsters.new
                @list[:monsters] = Monsters.all
                else
                @list[:monsters] = Monsters.all
            end
            puts "Thanks for waiting!"
            puts"-------------------"
            menu_monsters
        elsif input.downcase == 'spells'
            puts "Loading Spell list, it may take a few minutes"
            if Spells.all == []
            Spells.new
            @list[:spells] = Spells.all
            else
            @list[:spells] = Spells.all
            end
            puts "Thanks for waiting!"
            puts"-------------------"
            menu_spells
        else "Sorry that input is not valid"
            main_menu
        end
        
    end
    # -----------------------------------------------------------------------------------------

    def menu_monsters
        puts ''
        puts "Welcome to the Monsters Menu"
        puts "Please choose from the following options:"
        puts "If you want a list of Monsters type 'List Mons'"
        puts "If you want to choose a Monster and get its details, type 'By Name'"
        puts "If you want to get groups of Monsters by a selector, type 'By Group'"
        puts "If you want to see a random Monster, type 'Random'"
        puts "If you want to clear the terminal, type 'Clear'"
        puts "If you want to return to the Main Menu, type 'Main'"
        puts "If you want to exit, type 'exit' "
        puts " "
        gets_user_input_mons
    end

    def gets_user_input_mons
        input = gets.strip
        if input.downcase == "list mons"
            list_mons
        elsif input.downcase =='main'
            main_menu
        elsif input.downcase == "by name"
            puts "Type Monster name"
            input = gets.strip
             if @list["monsters"].any?{|monster| monster["name"] == input}
                monster_by_name(input)
                menu_monsters
             else puts "Sorry, no monster of that name"
                menu_monsters
            end
        elsif input.downcase == 'random'
            random_monster
        elsif input.downcase == 'by group'
            by_group
        elsif input.downcase == "clear"
            clear
        elsif input.downcase =="exit"
            goodbye
        else
            puts "Sorry, that input is not viable"
            puts " "
            menu_monsters
        end
    end 

    def random_monster
        r = @list[:monsters].sample
        mon = SingleMonster.new(r["name"])
        display_mon(mon)
        menu_monsters
    end

    def list_mons
        array =[]
        @list["monsters"].each.with_index(1) do |mon, index| array << "#{index}. #{mon["name"]}" end
        puts array
        menu_monsters
    end

    def display_mon(mon)
        puts ""
        puts "Name: " + "#{mon.name}"
        puts "Type: " + "#{mon.type}"
        if mon.subtype
        puts "Subtype: " + "#{mon.subtype}"
        end
        puts "Size: "+ "#{mon.size}" 
        puts "Alignment: " +"#{mon.alignment}"
        puts "Armour class: " + "#{mon.armor_class}"
        puts "Hit Points: " + "#{mon.hit_points}"
        puts "Hit Dice: " + "#{mon.hit_dice}"
        puts "Challenge Rating: " + "#{mon.challenge_rating}"
        puts "Speed: " + "#{mon.speed.map{|k,v| "#{k}: #{v}"}.join("\n")}"
        if mon.other_speeds
            puts "Other speeds: " + "#{mon.other_speeds}"
        end
        puts 'Ability Scores:'
        puts "  Str: "+ "#{mon.strength}"
        puts "  Dex: " + "#{mon.dexterity}"
        puts "  Con: " +  "#{mon.constitution}"
        puts "  Int: " + "#{mon.intelligence}"
        puts "  Wis: " +  "#{mon.wisdom}"
        puts "  Cha: " + "#{mon.charisma}"
        puts "" 
        puts "Proficiencies: " 
        puts "#{mon.proficiencies.map{|save| "#{save["name"]}: +#{save["value"]}"}.join("\n")}"
        puts ""
        puts "Damage and Condition Modifiers"
        puts "Damage Resistances: " + "#{mon.damage_resistances.join(", ")}"
        puts "Damage Vulnerabilities: " + "#{mon.damage_vulnerabilities.join(", ")}"
        puts "Damage Immunities: " + "#{mon.damage_immunities.join(", ")}"
        puts "Condition Immunities: " + "#{mon.condition_immunities.map{|value| value["name"]}.join(", ")}"
        puts ""
        puts "Sense: " + "#{mon.senses.map{|k,v| "#{k}: #{v}"}.join("\n")}"
        puts "Languages: " + "#{mon.languages}"
         if mon.special_abilities
            puts "Special Abilities: "
            puts special_abilities(mon)
        end

        puts "Actions:"
        puts "#{mon.actions.map{|k,v| "#{k}: #{v}"}.join("\n")}}"

        if mon.legendary_actions
            puts "Legendary Actions: "
            puts "#{mon.legendary_actions.map{|k,v| "#{k}: #{v}"}.join("\n")}}"
        end
    end

    def ability_usage(ability)
        if ability["usage"]['dice']
            "#{ability["usage"]['type']} of equal or higher than #{ability["usage"]['min_value']} on #{ability["usage"]['dice']}"
            else "#{ability["usage"]['times']} #{ability["usage"]['type']}"
        end
    end
    
    def special_abilities(mon)
        special = mon.special_abilities.map do |ability| 
            if ability["dc"] && !ability["usage"] && !ability["damage"]
                "#{ability["name"]}: #{ability["desc"]} \n
                Save Ability: #{ability["dc"]["dc_type"]["name"]} \n
                DC: #{ability["dc"]["dc_value"]}"
            elsif !ability["dc"] && ability["usage"] && !ability["damage"]
                "#{ability["name"]} (#{ability_usage(ability)}): #{ability["desc"]} \n"
            elsif ability["dc"] && ability["usage"] && !ability["damage"]
                "#{ability["name"]}: #{ability["desc"]} \n
                Save Ability: #{ability["dc"]["dc_type"]["name"]} \n
                DC: #{ability["dc"]["dc_value"]} \n
                Usage: #{ability_usage(ability)}"
            elsif ability["dc"] && ability["usage"] && ability["damage"]
                "#{ability["name"]}: #{ability["desc"]} \n
                Save Ability: #{ability["dc"]["dc_type"]["name"]} \n
                DC: #{ability["dc"]["dc_value"]} \n
                Usage: #{ability_usage(ability)} \n
                Damage: #{ability["damage"].map{|damage| "#{damage["damage_dice"]} +#{damage["damage_bonus"]} #{damage["damage_type"]["name"]} Damage"} }"
            else "#{ability["name"]}: #{ability["desc"]}"
            end
        end 
        special
    end
    # -----------------------------------------------------------------------------------------
    def menu_spells
        puts ''
        puts "Welcome to the Spells Menu"
        puts "Please choose from the following options:"
        puts "If you want a list of spells type 'List Spells'"
        puts "If you want to choose a spell and get its details, type 'By Name'"
        puts "If you want to get groups of spells by a selector, type 'By Group'"
        puts "If you want to see a random spell, type 'Random'"
        puts "If you want to clear the terminal, type 'Clear'"
        puts "If you want to return to the Main Menu, type 'Main'"
        puts "If you want to exit, type 'exit' "
        puts " "
        gets_user_input_spell
    end

    def gets_user_input_spell
        input = gets.strip
        if input.downcase == "list spells"
            list_spells
        elsif input.downcase =='main'
            main_menu
        elsif input.downcase == "by name"
            puts "Type Spell name"
            input = gets.strip
             if @list[:spells].any?{|spell| spell["name"] == input}
                spell_by_name(input)
                menu_spells
             else puts "Sorry, no spell of that name"
                menu_spells
            end
        elsif input.downcase == 'random'
            random_spell
        elsif input.downcase == 'by group'
            by_group
        elsif input.downcase == "clear"
            clear
        elsif input.downcase =="exit"
            goodbye
        else
            puts "Sorry, that input is not viable"
            puts " "
            menu_spells
        end
    end
        
  

    def by_group
        group = GroupSpells.new
        puts "Would you like to select via:"
        puts "Class, School, Level, if its a Ritual?"
        puts "Type 'Class', 'School', 'Level, or 'Ritual'"
        puts ''
        input = gets.strip
        if input.downcase == "class"
            by_klass(group)
        elsif input.downcase == 'school'
            by_school(group)
        elsif input.downcase == 'level'
            by_level(group)
        elsif input.downcase == 'ritual'
            by_ritual(group)
        else 
            puts "Sorry thats not an option!"
        end 
        menu_spells
    end

    def by_klass(group)
        puts "Please type 'List' for a list of options or input class:"
        input = gets.strip
        if input.downcase != 'list' && group.find_by_class(input)
            ls = group.find_by_class(input)
            spell_group= group.spells_by_collection(ls)
            display_list(spell_group)
            puts ''
        elsif input.downcase == 'list'
            display_options_classes
            puts ''
            by_klass(group)
        else puts "Sorry that class doesnt exist"
            by_klass(group)
        end
    end

    def by_school(group)
        puts "Please type 'List' for a list of options or input school name:"
        input = gets.strip
        if input.downcase != 'list' && group.find_by_school(input)
            ls= group.find_by_school(input)
            spell_group =  group.spells_by_collection(ls)
            display_list(spell_group)
            puts ''
        elsif input.downcase == 'list'
            display_options_schools
            puts ''
            by_school(group)
        else puts "Sorry that school doesnt exist"
            by_school(group)
        end
    end

    def by_level(group)
        puts "Input number between 1 & 9, or Input '0' for Cantrips"
        input = gets.strip
        if input.to_i < 10 && input.to_i >= 0
            ls=  group.find_by_level(input.to_i)
            spell_group = group.spells_by_collection(ls)
            puts ''
            display_list(spell_group)
        else puts "Sorry that level doesnt exist"
            by_level(group)
        end
    end

    def by_ritual(group)
            ls= group.find_by_ritual
            spell_group = group.spells_by_collection(ls)
            display_list(spell_group)
            puts ''
    end

    def display_options_classes 
        class_options =[]
        @list[:spells].each do |spell| spell["classes"].each do |klass| class_options << klass["name"] end end
        class_options.uniq!
        class_options.each{|klass| puts klass }
        
    end
    :spells

    def display_options_schools
        school_options =[]
        @list[:spells].each do |spell| school_options << spell["school"]["name"] end
        school_options.uniq!
        school_options.each{|school| puts school}
        
    end

    def display_list(spell_group)
        puts "Would you like to see just the Names, or the full information for the spell list?"
        puts "Type 'List' for just the names, 'Full' for full information," 
        puts "'Spell' to choose an individual spell, or 'Menu' to return to the Spells Menu"
        input = gets.strip
            if input.downcase == 'list'
                spell_group.each.with_index(1) {|spell, index| puts "#{index}. #{display_spell_name(spell)}"}
                display_list(spell_group)
            elsif input.downcase == 'full'
                spell_group.each {|spell| display_spell(spell)}
                display_list(spell_group)
            elsif input.downcase == 'spell'
                puts "Please input spell name"
                input = gets.strip
                if spell_by_name(input)
                    spell_by_name(input)
                    display_list(spell_group)
                else "Sorry thats not an option!"
                    display_list(spell_group)
                end
            elsif input.downcase == 'menu'
                menu_spells
            else puts "Sorry thats not an option!"
                puts ""
                display_list(spell_group)
            end 

            
    end

    def random_spell
        r = @list[:spells].sample
        spell = SingleSpell.new(r["name"])
        display_spell(spell)
        menu_spells
    end
    
    
    def list_spells
        array =[]
        @list[:spells].each.with_index(1) do |spell, index| array << "#{index}. #{spell["name"]}" end
        puts array
        menu_spells
    end

    def spell_by_name(name)
        spell = SingleSpell.new(name)
        display_spell(spell)
    end

    def display_spell_name(spell)
        spell.name
    end


    def display_spell(spell)
        puts ''
        puts "Name: "+ "#{spell.name}"
        puts "School: " + "#{spell.school["name"]}"
        puts "Casting time: " + "#{spell.casting_time}"
        puts "Classes: " + "#{spell.classes.map{|words| words["name"] if words["name"] !=nil || words["name"] !=""}.join(", ")}"
        puts "Level: " + "#{spell.level}"
        puts "Components: " + "#{spell.components.join(", ")}"
        puts "Material: " + "#{spell.material}"
        puts "Duration: " + "#{spell.duration}"
        puts "Can be cast as ritual? " + "#{spell.ritual == true ? "Yes" : "No"}"
        puts "Concentration: " + "#{spell.concentration == true ? "Required" : "No"}"
        puts "Range: " + "#{spell.range}"
        puts ''
        puts "Description: " + "#{spell.desc.map{|words| words if words !=nil || words !=""}.join("\n")}"
        if spell.higher_level
        puts "Higher Level: " + "#{spell.higher_level[0]}"
        end
        puts ''
    end

    # ----------------------------------------------------------------
    def clear
        system("clear")
        menu_spells
    end
        
    def goodbye
        puts "Ta-ra for now!"
        sleep(3)
        system("clear")
        exit
    end

end
