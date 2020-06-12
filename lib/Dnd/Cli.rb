class Cli


    def initialize
        puts "Welcome to the Dnd 5th Edition Spellbook!"
        puts "Loading Spell list, it may take a few minutes"
        Spells.new
        puts "Thanks for waiting!"
        puts"-------------------"
        menu
    end

    def menu
        puts ''
        puts "Welcome to the main menu"
        puts "Please choose from the following options:"
        puts "If you want a list of spells type 'List Spells'"
        puts "If you want to choose a spell and get its details, type 'By Name'"
        puts "If you want to exit, type 'exit' "
        puts " "
        gets_user_input
    end

    def gets_user_input
        input = gets.strip
        if input.downcase == "list spells"
            list_spells
        elsif input.downcase == "by name"
            puts "Type Spell name"
            input = gets.strip
            spell_by_name(input)
        elsif input.downcase =="exit"
            goodbye
        else
            puts "Sorry, that input is not viable"
            puts " "
            menu
        end
        end
        
    def clear
        system("clear")
        menu
    end
        
    def goodbye
        puts "Ta-ra for now!"
        sleep(3)
        system("clear")
    end
    
    
    def list_spells
        Spells.
        menu
    end

    def spell_by_name(name)
        spell = SingleSpell.new(name)
        puts ''
        puts "Name: "+ "#{spell.name}"
        puts "School: " + "#{spell.school["name"]}"
        puts "Casting time: " + "#{spell.casting_time}"
        puts "Level: " + "#{spell.level}"
        puts "Components: " + "#{spell.components.join(", ")}"
        puts "Material: " + "#{spell.material}"
        puts "Duration: " + "#{spell.duration}"
        puts "Concentration: " + "#{spell.concentration}"
        puts "Range: " + "#{spell.range}"
        puts ''
        puts "Description: " + "#{spell.desc[0]}"
        puts "Higher Level: " + "#{spell.higher_level[0]}"
        puts ''
        # puts "" + "#{spell.}"
        # puts "" + "#{spell.}"
        menu
    end
end
