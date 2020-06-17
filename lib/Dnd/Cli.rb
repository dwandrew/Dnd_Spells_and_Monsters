require_relative '../environment'

class Cli
    attr_reader :list
    @@self =''
    def initialize
        puts "~~ Welcome to the Dnd 5th Edition Infobook! ~~".colorize(:cyan)
        @list = {monsters: [], spells: []}
        @@self = self
        main_menu
    end

    def main_menu
        puts "Would you like to load Monsterbook, Spellbook, Both(comes with longer load time), or Exit?"
        puts "Input " +'Monsters'.colorize(:green) + ", " + 'Spells'.colorize(:green) +", " + 'Both'.colorize(:yellow) + " or " + "Exit".colorize(:red)
        input = gets.strip
        if input.downcase == "monsters" || input.downcase == "monster"
            if Monsters.all == []
                puts "Loading Monsters list, it may take a few minutes"
                Monsters.new
                @list[:monsters] = Monsters.all
                else
                @list[:monsters] = Monsters.all
            end
            puts"-------------------"
            puts "Thanks for waiting!"
            puts"-------------------"
            # menu_monsters
            MonsterMenu.new
        elsif input.downcase == "both"
            if Spells.all == []
                puts "Loading Spell list, it may take a few minutes"
                Spells.new
                @list[:spells] = Spells.all
                puts"-------------------"
                puts" Loaded Spell list "
                puts"Thanks for waiting!"
                puts"-------------------"
                else
                @list[:spells] = Spells.all
            end
            if Monsters.all == []
                puts "Loading Monsters list, it may take a few minutes"
                Monsters.new
                @list[:monsters] = Monsters.all
                puts"-------------------"
                puts"Loaded Monster list"
                puts"Thanks for waiting!"
                puts"-------------------"
                else
                @list[:monsters] = Monsters.all
            end
            main_menu
        elsif input.downcase == 'spells' || input.downcase == 'spell'
            if Spells.all == []
            puts "Loading Spell list, it may take a few minutes"
            Spells.new
            @list[:spells] = Spells.all
            else
            @list[:spells] = Spells.all
            end
            puts"-------------------"
            puts "Thanks for waiting!"
            puts"-------------------"
            # menu_spells
            SpellMenu.new
        elsif input.downcase == 'exit'
            goodbye
        else "Sorry that input is not valid"
            main_menu
        end
        
    end

    def self.main
        @@self
    end
    
    def goodbye
        puts "Ta-ra for now!"
        sleep(3)
        system("clear")
        exit
    end

end
