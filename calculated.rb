class Calculated
  include Singleton

  def data
    @data ||= load_data
    @origin_length ||= @data.length
    return @data
  end

  def write
    if data.length > @origin_length
      File.write('calculated.yml', @data.to_yaml)
    end
  end

  def load_data
    filename = 'calculated.yml'
    if File.file?(filename)
      YAML.load_file(filename)
    else
      {}
    end
  end

  def get(str)
    return @data[str]
  end

  def save(str, result)
    @data[str] = result
  end
end
