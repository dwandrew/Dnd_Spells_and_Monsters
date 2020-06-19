require_relative '../environment'

class Cli
    attr_reader :list
    def initialize
        puts "~~ Welcome to the Dnd 5th Edition Infobook! ~~".colorize(:cyan)
        main_menu
    end

    def main_menu
        puts "Would you like to load Monsterbook, Spellbook, Both(comes with longer load time),"
        puts "You can also access a Dice Roller or Exit?"
        puts "Input " +'Monsters'.colorize(:green) + ", " + 'Spells'.colorize(:green) +", " + 'Both'.colorize(:yellow) +", "+ 'Dice'.colorize(:cyan) + " or " + "Exit".colorize(:red)
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
        elsif input.downcase == 'dice'
            dice_cli
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
            puts"-------------------"
            puts"Loaded Monster list"
            puts"Thanks for waiting!"
            puts"-------------------"
            end
    end
    def spell_load
        if Spells.all_class == []
            puts "Loading Spell list, it may take a few minutes"
            Spells.new
            puts"-------------------"
            puts" Loaded Spell list "
            puts"Thanks for waiting!"
            puts"-------------------"
            else
        end
    end

    def dice_cli
        puts "Welcome to the Dice roller, here you can Roll dice and add modifiers to them."
        roll_bones
    end

    def roll_bones
        puts "Choose your dice to roll (input any number to act as the maximum on the dice), #{'Main'.colorize(:green)} to return to main menu, or #{'Exit'.colorize(:red)} to exit"
        input = gets.strip
        if input.downcase == "main"
            main_menu
        elsif input.downcase =="exit"
            goodbye
        elsif input.to_i >0  
            dice = random_roller(input.to_i)
            puts "You have chosen a D#{input}, would you like to add any modifiers to the roll?"
            mod = gets.strip
            dice_modifier(dice, mod, input)
            roll_bones
        else "Sorry that input not valid"
            roll_bones
        end
    end

    def random_roller(dice)
        rand(1..dice)
    end

    def dice_modifier(dice, mod, original)
        if mod.to_i >=1
        puts "Dice: #{dice} Mod: +#{mod} = #{dice.to_i+mod.to_i}"
        elsif mod.to_i <0
        puts "Dice: #{dice} Mod: #{mod} = #{dice.to_i+mod.to_i}"
        else
        puts "Dice: #{dice}"
        end
        puts "Roll again? Y/N"
        yn= gets.strip
        if yn.downcase == "y"
            dice_modifier(random_roller(original.to_i), mod, original)
        end
    end

    def goodbye
        puts "Ta-ra for now!"
        sleep(3)
        system("clear")
        exit
    end

end
