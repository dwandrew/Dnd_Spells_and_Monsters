require_relative '../environment'


class SpellMenu

    def initialize
        menu_spells
    end

    def menu_spells
        puts ''
        puts "Welcome to the #{"Spells Menu".colorize(:yellow)}"
        puts "Please choose from the following options:"
        puts "If you want a list of spells type #{'List Spells'.colorize(:green)}"
        puts "If you want to choose a spell and get its details, type #{'By Name'.colorize(:green)}"
        puts "If you want to get groups of spells by a selector, type #{'By Group'.colorize(:green)}"
        puts "If you want to see a random spell, type #{'Random'.colorize(:green)}"
        puts "If you want to clear the terminal, type #{'Clear'.colorize(:blue)}"
        puts "If you want to return to the Main Menu, type #{'Main'.colorize(:magenta)}"
        puts "If you want to exit, type #{'exit'.colorize(:red)}"
        puts " "
        gets_user_input_spell
    end

    def gets_user_input_spell
        input = gets.strip
        if input.downcase == "list spells"
            list_spells
        elsif input.downcase =='main'
            Cli.main.main_menu
        elsif input.downcase == "by name"
            puts "Type Spell name"
            input = gets.strip
             if Cli.main.list[:spells].any?{|spell| spell["name"] == input}
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
        puts "#{"Class".colorize(:green)}, #{"School".colorize(:green)}, #{"Level".colorize(:green)}, if its a #{"Ritual".colorize(:green)}?"
        puts "Type #{'Class'.colorize(:green)}, #{'School'.colorize(:green)}, #{'Level'.colorize(:green)}, or #{'Ritual'.colorize(:green)}"
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
        puts "Please type #{'List'.colorize(:green)} for a list of options or input class:"
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
        puts "Please type #{'List'.colorize(:green)} for a list of options or input school name:"
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
        puts "Input number between #{"1 & 9".colorize(:green)}, or Input #{'0'.colorize(:green)} for Cantrips"
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
        Cli.main.list[:spells].each do |spell| spell["classes"].each do |klass| class_options << klass["name"] end end
        class_options.uniq!
        class_options.each{|klass| puts klass }
        
    end

    def display_options_schools
        school_options =[]
        Cli.main.list[:spells].each do |spell| school_options << spell["school"]["name"] end
        school_options.uniq!
        school_options.each{|school| puts school}
        
    end

    def display_list(spell_group)
        puts "Would you like to see just the Names, or the full information for the spell list?"
        puts "Type #{'List'.colorize(:green)} for just the names, #{'Full'.colorize(:green)} for full information," 
        puts "#{'Spell'.colorize(:green)} to choose an individual spell, or #{'Menu'.colorize(:green)} to return to the Spells Menu"
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
        r = Cli.main.list[:spells].sample
        spell = SingleSpell.new(r["name"])
        display_spell(spell)
        menu_spells
    end
    
    
    def list_spells
        array =[]
        Cli.main.list[:spells].each.with_index(1) do |spell, index| array << "#{index}. #{spell["name"]}" end
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
        puts "Name: ".colorize(:cyan)+ "#{spell.name}"
        puts "School: ".colorize(:cyan) + "#{spell.school["name"]}"
        puts "Casting time: ".colorize(:cyan) + "#{spell.casting_time}"
        puts "Classes: ".colorize(:cyan) + "#{spell.classes.map{|words| words["name"] if words["name"] !=nil || words["name"] !=""}.join(", ")}"
        puts "Level: ".colorize(:cyan) + "#{spell.level}"
        puts "Components: ".colorize(:cyan) + "#{spell.components.join(", ")}"
        puts "Material: ".colorize(:cyan) + "#{spell.material}"
        puts "Duration: ".colorize(:cyan) + "#{spell.duration}"
        puts "Can be cast as ritual? ".colorize(:cyan) + "#{spell.ritual == true ? "Yes" : "No"}"
        puts "Concentration: ".colorize(:cyan) + "#{spell.concentration == true ? "Required" : "No"}"
        puts "Range: ".colorize(:cyan) + "#{spell.range}"
        puts ''
        puts "Description: ".colorize(:cyan) + "#{spell.desc.map{|words| words if words !=nil || words !=""}.join("\n")}"
        if spell.higher_level
        puts "Higher Level: ".colorize(:cyan) + "#{spell.higher_level[0]}"
        end
        puts ""
        puts "------   ------   ------".colorize(:yellow)
        puts ''
    end

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