module Adapters
  class Require < Core
    attr_accessor :data

    def initialize
      @data = []
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

    def dottie
      File.join(DOTTIES_DOTS, name)
    end

    def save!
      return if data.empty?
      File.open(dottie, 'w') do |file|
        file.write(data.join("\n"))
      end
      link_home(dottie)
    end
  end
end
