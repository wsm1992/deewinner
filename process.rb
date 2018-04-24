require 'ruby-poker'
require_relative 'game'
require_relative 'poker_hand'
require_relative 'card'

deck2 = "ac as ts tc"
deck1 = "2d ks kc kh qs qh qc 9c 9d 7h 7c 6c 6d 5s 5h 4s 4d 3h"

hand1 = PokerHand.new(deck1)
hand2 = PokerHand.new(deck2)

game = Game.new(hand1, hand2, PokerHand.new())

game.judge

if game.result
  puts 'hand1 win'
  puts 'first hand:'
  puts game.hand
else
  puts 'hand2 win'
end
