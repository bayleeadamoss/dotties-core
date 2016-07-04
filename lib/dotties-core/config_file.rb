class ConfigFile

  attr_accessor :file, :data

  ROOT = './components'

  def initialize(file)
    @file = file
    @data = {}
  end

  def get(tag, default = [])
    load!
    @data[tag.to_s] || default
  end

  def set(tag, value)
    load!
    @data[tag.to_s] = value
    save!
  end

  def add(tag, item)
    set(tag, get(tag).push(item))
  end

  def remove(tag, item)
    set(tag, get(tag).delete(item))
  end

  def banner
    "# DO NOT TOUCH - THIS FILE IS AUTO GENERATED\n"
  end

  def save!
    File.open(@file, 'w') do |file|
      file.write(banner + @data.to_yaml)
    end
  end

  def load!
    if @data.empty? and File.exists?(file)
      @data = YAML.load_file(file)
    end
  end
end
