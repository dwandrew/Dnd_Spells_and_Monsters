require 'pry'
require 'json'
require 'open-uri'
require 'net/http'
require 'colorize'

require_relative "./Dnd/version"
require_relative "./Dnd/api.rb"
require_relative './Dnd/cli.rb'
require_relative './Dnd/spells.rb'
require_relative './Dnd/single_spell.rb'
require_relative './Dnd/group_spells.rb'



module Dnd
  class Error < StandardError; end
  # Your code goes here...
end
