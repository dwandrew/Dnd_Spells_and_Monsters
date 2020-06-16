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
             if Cli.main.list[:monsters].any?{|monster| monster["name"] == input}
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
        mon = SingleMonster.new(r["name"])
        display_mon(mon)
        menu_monsters
    end

    def list_mons
        array =[]
        Cli.main.list[:monsters].each.with_index(1) do |mon, index| array << "#{index}. #{mon["name"]}" end
        puts array
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
        puts "  Str: ".colorize(:yellow)+ "#{mon.strength}"
        puts "  Dex: ".colorize(:yellow) + "#{mon.dexterity}"
        puts "  Con: ".colorize(:yellow) +  "#{mon.constitution}"
        puts "  Int: ".colorize(:yellow) + "#{mon.intelligence}"
        puts "  Wis: ".colorize(:yellow) +  "#{mon.wisdom}"
        puts "  Cha: ".colorize(:yellow) + "#{mon.charisma}"
        puts "" 
        puts "Proficiencies: ".colorize(:cyan) 
        puts "#{mon.proficiencies.map{|save| "#{save["name"]}: +#{save["value"]}"}.join("\n")}"
        puts ""
        puts "Damage and Condition Modifiers".colorize(:cyan)
        puts "Damage Resistances: ".colorize(:light_red) + "#{mon.damage_resistances.join(", ")}"
        puts "Damage Vulnerabilities: ".colorize(:light_red) + "#{mon.damage_vulnerabilities.join(", ")}"
        puts "Damage Immunities: ".colorize(:light_red) + "#{mon.damage_immunities.join(", ")}"
        puts "Condition Immunities: ".colorize(:light_red) + "#{mon.condition_immunities.map{|value| value["name"]}.join(", ")}"
        puts ""
        puts "Senses: ".colorize(:cyan)
        puts "#{mon.senses.map{|k,v| "#{k}: #{v}"}.join("\n")}"
        puts "Languages: ".colorize(:cyan)
        puts "#{mon.languages}"
         if mon.special_abilities
            puts ''
            puts "Special Abilities: ".colorize(:cyan)
            puts special_abilities(mon)
        end
        puts ''
        puts "Actions:".colorize(:cyan)
        puts actions(mon)

        if mon.reactions
            puts ''
            puts "Reactions: ".colorize(:cyan)
            puts "#{mon.reactions.map{|action| "#{action["name"]}: #{action["desc"]} \n"}.join("\n")}
            "
        end
        if mon.legendary_actions
            puts ''
            puts "Legendary Actions: ".colorize(:cyan)
            puts "#{mon.legendary_actions.map{|action| "#{action["name"]}: #{action["desc"]} \n"}.join("\n") }"
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
            "#{action["name"]} (#{ability_usage(action)}): #{action["desc"]}
            "
            
            else 
            "#{action["name"]}: #{action["desc"]}
            "
            end
        end
    end
    
    def special_abilities(mon)
        special = mon.special_abilities.map do |ability| 
            if ability["dc"] && !ability["usage"] && !ability["damage"]
                "#{ability["name"]}: #{ability["desc"]}
                "
            elsif !ability["dc"] && ability["usage"] && !ability["damage"]
                "#{ability["name"]} (#{ability_usage(ability)}): #{ability["desc"]} \n"
            elsif ability["dc"] && ability["usage"] && !ability["damage"]
                "#{ability["name"]}: #{ability["desc"]} \n
                Usage: #{ability_usage(ability)}
                "
            elsif ability["dc"] && ability["usage"] && ability["damage"]
                "#{ability["name"]}: #{ability["desc"]} \n
                Usage: #{ability_usage(ability)} \n
                Damage: #{ability["damage"].map{|damage| "#{damage["damage_dice"]} +#{damage["damage_bonus"]} #{damage["damage_type"]["name"]} Damage"} }
                "
            else "#{ability["name"]}: #{ability["desc"]}
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
            ls=  group.find_by_cr(input)
            if ls == []
                puts"Sorry, no monsters of that CR exist"
                by_cr(group)
            else
            mon_group = group.mons_by_collection(ls)
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
            ls = group.find_by_type(input)
            mon_group = group.mons_by_collection(ls)
            display_mon_list(mon_group)
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
            ls = group.find_by_size(input)
            mon_group = group.mons_by_collection(ls)
            display_mon_list(mon_group)
            puts''
        else puts 'Sorry that size doesnt exist'
            by_size(group)
        end
    end
   
    def display_options_type
        type_options =[]
        Cli.main.list[:monsters].each do |monster| type_options << monster["type"] end
        type_options.uniq!
        type_options.each{|type| puts type }
    end

    def display_options_size
        type_options =[]
        Cli.main.list[:monsters].each do |monster| type_options << monster["size"] end
        type_options.uniq!
        type_options.each{|type| puts type }
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
