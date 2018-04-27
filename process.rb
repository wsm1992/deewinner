require 'ruby-poker'
require 'yaml'
require 'singleton'
require 'fileutils'
require_relative 'calculated'
require_relative 'game'
require_relative 'poker_hand'
require_relative 'card'


first_player = ARGV[0]
first_player ||= 'A'
turn = first_player == 'A' ? 1 : 2

deck1 = ARGV[turn]
deck2 = ARGV[3 - turn]
last_hand = ARGV[3]

deck1 ||= "3c 4d 4h 5c 5d qh qd ks kc ah 2h"
deck2 ||= "6c 2c 2d"
last_hand ||= ""



#deck2 = "ac as ts tc"
#deck1 = "2d ks kc kd qs qh qc 9c 9d 7h 7c 6s 6d 5s 5h 4s 4d 3h"
#last_hand = ""

#deck1 = "2s ks kh kc qs qh 8s 8h 8c 6d 6c 4c 4d 3d"
#deck2 = "as ac ts th 6h"
#last_hand = ""

hand1 = PokerHand.new(deck1)
hand2 = PokerHand.new(deck2)


game = Game.new(hand1, hand2, PokerHand.new(last_hand))
Calculated.instance.data

turns = ['', 'A', 'B']
begin
  game.judge
  puts 'this game: ' + game.to_s
  puts ''
  puts ((game.result == (turn == 1)) ? 'A' : 'B') + ' will WIN !!!!!'

  if game.result
    first_hand = game.hand.to_s
    first_hand = 'PASS' if first_hand == ""
    puts 'first hand: ' + first_hand
  end

  #puts 'calculated:'
  #puts Calculated.instance.data.length
ensure
  Calculated.instance.write
end
