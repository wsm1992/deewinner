class Game
  attr_accessor :hand1, :hand2, :last_hand, :result, :hand, :step, :layer
  def initialize(hand1, hand2, last_hand, step=nil, layer=0)
    @@calculated ||= Game.load_calculated
    @@calculated_length ||= Game.load_calculated.length
    @hand1 = hand1
    @hand2 = hand2
    @last_hand = last_hand
    @step = step
    @layer = layer
    if @layer < 2
      puts 'step:'
      puts @step
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
      puts @@calculated.length
      puts ''
    end
  end

  def judge
    @result = false
    i = 0
    legals = legal_hands#.shuffle
    legals.each do |hand|
      i = i+1
      @step = "#{i} / #{legal_hands.length}"
      left_hand = get_left_hand(hand)
      if left_hand.length == 0
        @result = true
        @hand = hand
      else
        g = Game.new(@hand2, left_hand, hand, @step, @layer + 1)
        if !@@calculated[g.to_s].nil?
          g.result = @@calculated[g.to_s]
        else
          g.judge
          @@calculated[g.to_s] = g.result
        end
        @result = !g.result
      end
      if @result
        @hand = hand
        break
      end
    end
    return @result
  end

  def get_left_hand(hand)
    if @hand1.to_a != hand.to_a
      return PokerHand.new(@hand1.to_a - hand.to_a)
    else
      return PokerHand.new
    end
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
    "#{@hand1.to_s} #{@hand2.to_s} #{@last_hand.to_s}"
  end

  def self.calculated
    @@calculated
  end

  def self.write_calculated
    if Game.calculated.length > @@calculated_length
      File.write('calculated.yml', Game.calculated.to_yaml)
    end
  end

  def self.load_calculated
    filename = 'calculated.yml'
    if File.file?(filename)
      YAML.load_file(filename)
    else
      {}
    end
  end
end
