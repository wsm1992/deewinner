class Game
  attr_accessor :hand1, :hand2, :last_hand, :result, :hand, :layer
  def initialize(hand1, hand2, last_hand, layer=0)
    @calculated = Calculated.instance
    @hand1 = hand1
    @hand2 = hand2
    @last_hand = last_hand
    @layer = layer
    @i = 0
    log_game
  end

  def judge
    cal_data = @calculated.get(to_s)
    if !cal_data.nil?
      @result = cal_data
    else
      @result = false
      legals = legal_hands#.shuffle
      legals.each do |hand|
        judge_next_hand(hand)
        break if @result
      end
      @calculated.save(to_s, @result)
    end
    return @result
  end

  def judge_next_hand(hand)
    @i = @i+1
    puts @step = "#{@i} / #{legal_hands.length}" if layer < 1
    if hand1.length == hand.length
      @result = true
    else
      left_hand = PokerHand.new(@hand1 - hand)
      g = Game.new(@hand2, left_hand, hand, @layer + 1)
      g.judge
      @result = !g.result
    end
    @hand = hand if @result
    @result
  end

  def legal_hands
    amount = @last_hand.length
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
      result = legal_cards + legal_fives + legal_threes + legal_pairs
    end
    if amount != 0
      result << pass
    end
    result
  end

  def legal_cards
    result = @hand1.to_a.map{|card| PokerHand.new([card])}
    if @last_hand == pass
      return result
    else
      return result.select{|card| card > @last_hand}
    end
  end

  def legal_pairs
    result = []
    @hand1.pairs.each do |pair|
      result << pair if pair > @last_hand
    end
    return result
  end

  def legal_threes
    result = []
    @hand1.threes.each do |three|
      result << three if three > @last_hand
    end
    return result
  end

  def legal_fives
    result = []
    @hand1.fives.each do |five|
      result << five if five > @last_hand
    end
    return result
  end

  def pass
    PokerHand.new
  end

  def to_s
    "#{@hand1.to_s}_#{@hand2.to_s}_#{@last_hand.to_s}"
  end

  def log_game
    if @layer < 2
      puts 'layer:'
      puts @layer
      puts 'last hand:'
      puts @last_hand
      puts 'hand1:'
      puts @hand1
      puts ''
      puts 'hand2:'
      puts @hand2
      puts ''
      puts 'calculated:'
      puts @calculated.data.length
      puts ''
    end
  end
end
