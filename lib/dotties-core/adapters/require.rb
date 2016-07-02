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
      File.open(File.join('configs', name), 'w') do |file|
        file.write(data.join("\n"))
      end
    end
  end
end
