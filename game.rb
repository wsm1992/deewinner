class Game
  attr_accessor :hand1, :hand2, :current, :last_hand, :result, :hand, :round, :layer
  def initialize(hand1, hand2, last_hand, round=nil, layer=0)
    @hand1 = hand1
    @hand2 = hand2
    @current = @hand1
    @last_hand = last_hand
    @round = round
    @layer = layer
    if layer < 2
      puts 'round:'
      puts round
      puts 'layer:'
      puts layer
      puts 'last hand:'
      puts last_hand
      puts 'hand1:'
      puts hand1
      puts ''
      puts 'hand2:'
      puts hand2
      puts ''
    end
  end

  def judge
    @result = false
    i = 0
    legals = legal_hands.shuffle
    legals.each do |hand|
      i = i+1
      if round.nil?
        flag = "#{i} / #{legal_hands.length}"
      else
        flag = round
      end
      if hand1.to_a != hand.to_a
        left_hand = PokerHand.new(hand1.to_a - hand.to_a)
      else
        left_hand = PokerHand.new
      end
      if left_hand.length == 0
        @result = true
        @hand = hand
      else
        g = Game.new(hand2, left_hand, hand, flag, layer + 1)
        g.judge
        @result = !g.result

      end
      if @result
        @hand = hand
        break
      end
    end
    return @result
  end

  def legal_hands
    amount = last_hand.length
    result = []
    if amount == 1
      result = legal_cards
    elsif amount == 2
      result = legal_pairs
    elsif amount == 3
      result = legal_threes
    elsif amount == 5
      result = legal_fives
    else
      result = legal_fives + legal_threes + legal_pairs + legal_cards
    end
    if amount != 0
      result << pass
    end
    result
  end

  def legal_cards
    lh = last_hand
    if lh == pass
      lh = PokerHand.new('ls')
    end
    result = []
    face = lh.max.face
    suit = lh.map{|card| card.suit}.max
    cards = current.to_a
    cards.each do |card|
      if card.face > face
        result << PokerHand.new([card])
      elsif card.face == face
        if card.suit > suit
          result << PokerHand.new([card])
        end
      end
    end
    result
  end

  def legal_pairs
    lh = last_hand
    if lh == pass
      lh = PokerHand.new('ls lh')
    end
    result = []
    face = lh.max.face
    suit = lh.map{|card| card.suit}.max
    pairs = current.pairs
    pairs.each do |k, v|
      if k > face
        result << PokerHand.new(v)
      elsif k == face
        if v.map{|card| card.suit}.max > suit
          result << PokerHand.new(v[0..1])
        end
      end
    end
    result
  end

  def legal_threes
    lh = last_hand
    if lh == pass
      lh = PokerHand.new('ls lh lc')
    end
    result = []
    face = lh.max.face
    threes = current.threes
    threes.each do |k, v|
      if k > face
        result << PokerHand.new(v[0..2])
      end
    end
    result
  end

  def legal_fives
    result = []
    fives = current.fives
    fives.each do |five|
      if five > last_hand
        result << five
      end
    end
    result
  end

  def pass
    PokerHand.new
  end
end
