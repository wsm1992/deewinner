class Calculated
  include Singleton

  def data
    @path = 'cal/'
    @exist_data ||= {}
    @data ||= {}
    @origin_length ||= @data.length
    return @data
  end

  def write
    Dir.mkdir(@path) unless File.exists?(@path)
    @data.each do |k, v|
      File.write(@path + k, v.to_yaml)
    end
  end

  def get(str)
    if @exist_data[str]
      return @exist_data[str]
    end
    if @data[str]
      return @data[str]
    end
    if File.file?(@path + str)
      cal = YAML.load_file(@path + str)
      cal['h'] = PokerHand.new(cal['h'])
      @exist_data[str] = cal
      return cal
    else
      return nil
    end
  end

  def save(str, result, hand)
    cal = {}
    cal['r'] = result
    cal['h'] = hand.to_a.join(' ')
    @data[str] = cal
  end
end
