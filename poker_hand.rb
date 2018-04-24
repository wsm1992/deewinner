class PokerHand
  def pairs
    cards = to_a
    faces = cards.map{|card| card.face}
    if faces.length == faces.uniq.length
      []
    else
      duplicates = cards.group_by{ |card| card.face }.select { |k, v| v.size > 1 }
    end
  end
  
  def threes
    cards = to_a
    faces = cards.map{|card| card.face}
    if faces.length == faces.uniq.length
      []
    else
      duplicates = cards.group_by{ |card| card.face }.select { |k, v| v.size > 2 }
    end
  end

  def fives
    dee_ranks = ['Royal Flush', 'Straight Flush', 'Four of a kind', 'Full house', 'Flush', 'Straight']
    result = []
    cards = to_a
    five_array = cards.combination(5)
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
      if flush? && !hand.flush?
        true
      elsif !flush? && hand.flush?
        false
      else
        max > hand.max
      end
    end
  end
end
