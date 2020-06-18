require_relative '../environment'

class Cli
    attr_reader :list
    @@self =''
    def initialize
        puts "~~ Welcome to the Dnd 5th Edition Infobook! ~~".colorize(:cyan)
        @list = {monsters: [], spells: []}
        @@self = self # <---  this is a nope
        main_menu
    end

    def main_menu
        puts "Would you like to load Monsterbook, Spellbook, Both(comes with longer load time), or Exit?"
        puts "Input " +'Monsters'.colorize(:green) + ", " + 'Spells'.colorize(:green) +", " + 'Both'.colorize(:yellow) + " or " + "Exit".colorize(:red)
        input = gets.strip
        if input.downcase == "monsters" || input.downcase == "monster"
            monster_load
            MonsterCli.new
        elsif input.downcase == "both"
            spell_load
            monster_load
            main_menu
        elsif input.downcase == 'spells' || input.downcase == 'spell'
            spell_load
            SpellCli.new
        elsif input.downcase == 'exit'
            goodbye
        else "Sorry that input is not valid"
            main_menu
        end
        
    end

    def monster_load
        if Monsters.all_class == []
            puts "Loading Monsters list, it may take a few minutes"
            Monsters.new
            @list[:monsters] = Monsters.all_class
            puts"-------------------"
            puts"Loaded Monster list"
            puts"Thanks for waiting!"
            puts"-------------------"
            else
            @list[:monsters] = Monsters.all_class
            end
    end
    def spell_load
        if Spells.all_class == []
            puts "Loading Spell list, it may take a few minutes"
            Spells.new
            @list[:spells] = Spells.all_class
            puts"-------------------"
            puts" Loaded Spell list "
            puts"Thanks for waiting!"
            puts"-------------------"
            else
            @list[:spells] = Spells.all_class
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
