require 'ruby-poker'
require 'yaml'
require_relative 'game'
require_relative 'poker_hand'
require_relative 'card'

deck2 = "ac as ts tc"
deck1 = "2d ks kc kd qs qh qc 9c 9d 7h 7c 6s 6d 5s 5h 4s 4d 3h"

#deck1 = "3c 4d 4h 5c 5d qh qd ks kc ah 2h"
#deck2 = "6c 2c 2d"

hand1 = PokerHand.new(deck1)
hand2 = PokerHand.new(deck2)

game = Game.new(hand1, hand2, PokerHand.new())

begin
game.judge

if game.result
    puts 'hand1 win'
    puts 'first hand:'
    puts game.hand
  else
    puts 'hand2 win'
  end

  puts 'calculated:'
  puts Game.calculated.length
ensure
  if Game.calculated.length > 0
    Game.write_calculated
  end
end
