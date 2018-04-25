class PokerHand
  def pairs
    return to_a.combination(2).select{|hand| hand[0].face == hand[1].face}.map{|hand| PokerHand.new(hand)}
  end
  
  def threes
    return to_a.combination(3).select{|hand| hand[0].face == hand[1].face && hand[0].face == hand[2].face}.map{|hand| PokerHand.new(hand)}
  end

  def fives
    dee_ranks = ['Royal Flush', 'Straight Flush', 'Four of a kind', 'Full house', 'Flush', 'Straight']
    result = []
    five_array = to_a.combination(5)
    five_array.each do |five|
      ph = PokerHand.new(five)
      if dee_ranks.include?(ph.rank)
        result << ph
      end
    end
    result
  end

  def length
    to_a.length
  end

  def straight_flush?
    straight? && flush?
  end

  def straight?
    return false if length < 5
    faces = to_a.map{|card| card.face == 14 ? 1 : card.face}.sort
    result = contin?(faces)
    if !result
      faces = faces.map{|face| face == 13 ? 0 : face}.sort
      result = contin?(faces)
    end
    return result
  end

  def contin?(faces)
    for i in 1..4
      if faces[i] - faces[0] != i
        return false
      end
    end
  end

  alias_method :bigger, :>

  def >(hand)
    return true if hand.length == 0
    if !straight? && !hand.straight?
      bigger hand
    else
      if (flush? && !hand.flush?) || (!flush? && hand.flush?)
        if flush?
          true
        else
          false
        end
      else
        if max.face != hand.max.face
          max.face > hand.max.face
        else
          second_max = sort[-2]
          hand_second_max = hand.to_a.sort[-2]
          if second_max.face != hand_second_max.face
            second_max.face > hand_second_max.face
          else
            max.suit > hand.max.suit
          end
        end
      end
    end
  end
end
