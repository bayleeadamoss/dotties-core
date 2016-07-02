module Adapters
  class Require
    attr_accessor :data

    def initialize
      self.data = []
    end

    def name
      self.class.name
        .split('::')
        .last
        .gsub(/([A-Z][a-z]+)/, '.\1')
        .gsub(/.(.*)/, '\1')
        .downcase
    end

    def likes?(file_name)
      file_name == name
    end

    def push(path)
      data << template(path)
    end

    def save!
      return if data.empty?
      f = File.new(File.join('configs', name), 'w')
      f.write(data.join("\n"))
      f.close
    end
  end
end
