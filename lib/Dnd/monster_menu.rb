require_relative '../environment'

class MonsterMenu

    def initialize
        menu_monsters
    end

    def menu_monsters
        puts ''
        puts "Welcome to the #{"Monsters Menu".colorize(:yellow)}"
        puts "Please choose from the following options:"
        puts "If you want a list of Monsters type #{'List Mons'.colorize(:green)}"
        puts "If you want to choose a Monster and get its details, type #{'By Name'.colorize(:green)}"
        puts "If you want to get groups of Monsters by a selector, type #{'By Group'.colorize(:green)}"
        puts "If you want to see a random Monster, type #{'Random'.colorize(:green)}"
        puts "If you want to clear the terminal, type #{'Clear'.colorize(:blue)}"
        puts "If you want to return to the Main Menu, type #{'Main'.colorize(:magenta)}"
        puts "If you want to exit, type #{'exit'.colorize(:red)}"
        puts " "
        gets_user_input_mons
    end

    def gets_user_input_mons
        input = gets.strip
        if input.downcase == "list mons"
            list_mons
        elsif input.downcase =='main'
            Cli.main.main_menu
        elsif input.downcase == "by name"
            puts "Type Monster name"
            input = gets.strip
             if Cli.main.list[:monsters].any?{|monster| monster.name == input}
                monster_by_name(input)
                menu_monsters
             else puts "Sorry, no monster of that name"
                menu_monsters
            end
        elsif input.downcase == 'random'
            random_monster
        elsif input.downcase == 'by group'
            mon_by_group
        elsif input.downcase == "clear"
            mon_clear
        elsif input.downcase =="exit"
            goodbye
        else
            puts "Sorry, that input is not viable"
            puts " "
            menu_monsters
        end
    end 

    def mon_clear
        system("clear")
        menu_monsters
    end
    def monster_by_name(name)
        mon = SingleMonster.new(name) 
        display_mon(mon)
    end

    def random_monster
        r = Cli.main.list[:monsters].sample
        display_mon(r)
        menu_monsters
    end

    def list_mons
        list = Cli.main.list[:monsters].map.with_index(1) do |mon, index| "#{index}. #{mon.name}" end
        puts list
        menu_monsters
    end

    def display_mon(mon)
        puts ""
        puts "Name: ".colorize(:cyan) + "#{mon.name}"
        puts "Type: ".colorize(:cyan) + "#{mon.type}"
        if mon.subtype
        puts "Subtype: ".colorize(:cyan) + "#{mon.subtype}"
        end
        puts "Size: ".colorize(:cyan)+ "#{mon.size}" 
        puts "Alignment: ".colorize(:cyan) +"#{mon.alignment}"
        puts "Armour class: ".colorize(:cyan) + "#{mon.armor_class}"
        puts "Hit Points: ".colorize(:cyan) + "#{mon.hit_points}"
        puts "Hit Dice: ".colorize(:cyan) + "#{mon.hit_dice}"
        puts "Challenge Rating: ".colorize(:cyan) + "#{mon.challenge_rating}"
        puts "Speed: ".colorize(:cyan) + "#{mon.speed.map{|k,v| "#{k}: #{v}"}.join("\n")}"
        if mon.other_speeds
            puts "Other speeds: ".colorize(:cyan) + "#{mon.other_speeds}"
        end
        puts 'Ability Scores:'.colorize(:cyan)
        puts "  Str: ".colorize(:yellow)+ "#{mon.strength}" +" (#{abilty_score_mod(mon.strength)})"
        puts "  Dex: ".colorize(:yellow) + "#{mon.dexterity}"+" (#{abilty_score_mod(mon.dexterity)})"
        puts "  Con: ".colorize(:yellow) +  "#{mon.constitution}"+" (#{abilty_score_mod(mon.constitution)})"
        puts "  Int: ".colorize(:yellow) + "#{mon.intelligence}"+" (#{abilty_score_mod(mon.intelligence)})"
        puts "  Wis: ".colorize(:yellow) +  "#{mon.wisdom}"+" (#{abilty_score_mod(mon.wisdom)})"
        puts "  Cha: ".colorize(:yellow) + "#{mon.charisma}"+" (#{abilty_score_mod(mon.charisma)})"
        puts "" 
        if mon.proficiencies!=[]
        puts "Proficiencies: ".colorize(:cyan) 
        puts "#{mon.proficiencies.map{|save| "#{save["name"]}: +#{save["value"]}"}.join("\n")}"  
        end
        damage_and_condition_modifiers(mon)
        puts ""
        puts "Senses: ".colorize(:cyan)
        puts "#{mon.senses.map{|k,v| "#{k}: #{v}"}.join("\n")}"
        if mon.languages!=""
        puts "Languages: ".colorize(:cyan)
        puts "#{mon.languages}"
        end
         if mon.special_abilities
            puts ''
            puts "Special Abilities: ".colorize(:cyan)
            puts special_abilities(mon)
        end
        puts ''
        if mon.actions
        puts "Actions:".colorize(:cyan)
        puts actions(mon)
        end
        if mon.reactions
            puts ''
            puts "Reactions: ".colorize(:cyan)
            puts "#{mon.reactions.map{|action| "#{action["name"]}".colorize(:light_blue)+": #{action["desc"]} \n"}.join("\n")}
            "
        end
        if mon.legendary_actions
            puts ''
            puts "Legendary Actions: ".colorize(:cyan)
            puts "#{mon.legendary_actions.map{|action| "#{action["name"]}:".colorize(:light_blue)+" #{action["desc"]} \n"}.join("\n") }
            "
        end
        
        puts "------   ------   ------".colorize(:yellow)
        puts ""
    end
    
    def abilty_score_mod(score)
        score-=10
        score/=2
        if score >=0
            "+#{score}"
        else 
            "#{score}"
        end
    end

    def damage_and_condition_modifiers(mon)
        if mon.damage_resistances !=[] || mon.damage_vulnerabilities!=[] || mon.damage_immunities!=[] || mon.condition_immunities!=[]
            puts "Damage and Condition Modifiers".colorize(:cyan)
            if mon.damage_resistances !=[]
            puts "Damage Resistances: ".colorize(:light_red) + "#{mon.damage_resistances.join(", ")}"
            end
            if mon.damage_vulnerabilities!=[]
            puts "Damage Vulnerabilities: ".colorize(:light_red) + "#{mon.damage_vulnerabilities.join(", ")}"
            end
            if mon.damage_immunities!=[]
            puts "Damage Immunities: ".colorize(:light_red) + "#{mon.damage_immunities.join(", ")}"
            end
            if mon.condition_immunities!=[]
            puts "Condition Immunities: ".colorize(:light_red) + "#{mon.condition_immunities.map{|value| value["name"]}.join(", ")}"
            end
        end
    end

    def ability_usage(ability)
        if ability["usage"]['dice']
            "#{ability["usage"]['type']} of equal or higher than #{ability["usage"]['min_value']} on #{ability["usage"]['dice']}"
            else "#{ability["usage"]['times']} #{ability["usage"]['type']}"
        end
    end

    def actions(mon)
        actions = mon.actions.map do |action| 
            if action["usage"]
            "#{action["name"]} (#{ability_usage(action)}):".colorize(:light_blue)+" #{action["desc"]}
            "
            
            else 
            "#{action["name"]}".colorize(:light_blue)+": #{action["desc"]}
            "
            end
        end
    end
    
    def special_abilities(mon)
        special = mon.special_abilities.map do |ability| 
            if ability["dc"] && !ability["usage"] && !ability["damage"]
                "#{ability["name"]}:".colorize(:light_blue)+" #{ability["desc"]}
                "
            elsif !ability["dc"] && ability["usage"] && !ability["damage"]
                "#{ability["name"]} (#{ability_usage(ability)}):".colorize(:light_blue)+" #{ability["desc"]} \n"
            elsif ability["dc"] && ability["usage"] && !ability["damage"]
                "#{ability["name"]}:".colorize(:light_blue)+" #{ability["desc"]} \n
                Usage: #{ability_usage(ability)}
                "
            elsif ability["dc"] && ability["usage"] && ability["damage"]
                "#{ability["name"]}:".colorize(:light_blue)+" #{ability["desc"]} \n
                Usage: #{ability_usage(ability)} \n
                Damage: #{ability["damage"].map{|damage| "#{damage["damage_dice"]} +#{damage["damage_bonus"]} #{damage["damage_type"]["name"]} Damage"} }
                "
            else "#{ability["name"]}:".colorize(:light_blue)+" #{ability["desc"]}
                "
            end
        end 
    end

    def mon_by_group
        group = GroupMonsters.new
        puts "Would you like to select via:"
        puts "#{"Combat rating".colorize(:green)}, #{"Type".colorize(:green)}, or #{"Size".colorize(:green)}?"
        puts "Type #{'CR'.colorize(:green)}, #{'Type'.colorize(:green)}, or #{'Size'.colorize(:green)}"
        puts ''
        input = gets.strip
        if input.downcase == "cr"
            by_cr(group)
        elsif input.downcase == 'type'
            by_type(group)
        elsif input.downcase == 'size'
            by_size(group)
        else 
            puts "Sorry thats not an option!"
        end 
        menu_monsters
    end

    def display_mon_name(mon)
        mon.name
    end

    def by_cr(group)
        puts "Input number between #{"0 & 30".colorize(:green)}, or Input #{'1/2'.colorize(:green)}, #{'1/4'.colorize(:green)} or #{'1/8'.colorize(:green)}"
        input = gets.strip
        if input.to_f <= 30 && input.to_f >= 0
            mon_groupb = group.find_by_cr(input)
            if mon_group == []
                puts"Sorry, no monsters of that CR exist"
                by_cr(group)
            else
            puts ''
            display_mon_list(mon_group)
            end
        else puts "Sorry that level doesnt exist"
            by_cr(group)
        end
    end

    def by_type(group)
        puts "Input the type of Monsters you want to view, or #{'List'.colorize(:green)} to see the options"
        input = gets.strip
        if input.downcase !="list" && group.find_by_type(input) !=[]
            type_list = group.find_by_attr(input, "type")
            display_mon_list(type_list)
            puts''
        elsif input.downcase == "list"
            display_options_type
            by_type(group)
        else puts 'Sorry that Type doesnt exist'
            by_type(group)
        end
    end

    def by_size(group)
        puts "Input the size of Monsters you want to view, or #{'List'.colorize(:green)} to see the options"
        input = gets.strip
        if input.downcase == "list"
            display_options_size
            by_size(group)
        elsif input.downcase !="list" && group.find_by_size(input) !=[]
            size_list = group.find_by_attr(input, "size")
            display_mon_list(size_list
            puts''
        else puts 'Sorry that size doesnt exist'
            by_size(group)
        end
    end
   
    def display_options_type
        Cli.main.list[:monsters].map { |monster| monster.type }.uniq.each{|type| puts type }
    end

    def display_options_size
        Cli.main.list[:monsters].map {|monster| type_options << monster.size}.uniq.each{|size| puts size }
    end

    def display_mon_list(mon_group)
        puts "Would you like to see just the Names, or the full information for the Monster list?"
        puts "Type #{'List'.colorize(:green)} for just the names, #{'Full'.colorize(:green)} for full information," 
        puts "#{'Monster'.colorize(:green)} to choose an individual Monster, or #{'Menu'.colorize(:green)} to return to the Monster Menu"
        input = gets.strip
            if input.downcase == 'list'
                mon_group.each.with_index(1) {|mon, index| puts "#{index}. #{display_mon_name(mon)}"}
                display_mon_list(mon_group)
                puts''
            elsif input.downcase == 'full'
                mon_group.each {|mon| display_mon(mon)}
                display_mon_list(mon_group)
                puts ''
            elsif input.downcase == 'monster'
                puts "Please input monster name"
                input = gets.strip
                if Cli.main.list[:monsters].any?{|monster| monster["name"] == input}
                    monster_by_name(input)
                    puts ''
                    display_mon_list(mon_group)
                else puts "Sorry, no monster of that name"
                    display_mon_list(mon_group)
                end
            elsif input.downcase == 'menu'
                menu_monsters
            else puts "Sorry thats not an option!"
                puts ""
                display_mon_list(mon_group)
            end
    end

    def goodbye
        puts "Ta-ra for now!"
        sleep(3)
        system("clear")
        exit
    end


end
