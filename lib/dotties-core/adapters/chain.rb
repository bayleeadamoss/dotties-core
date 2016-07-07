module Adapters
  class Chain < Core
    attr_accessor :configs

    def initialize
      @configs = []
    end

    def name
      self.class.name
        .split('::')
        .last
        .gsub(/([A-Z][a-z]+)/, '.\1')
        .gsub(/.(.*)/, '\1')
        .downcase
    end

    def likes?(base)
      base == name
    end

    def push(path)
      configs << path
    end

    def link(save_to, include_path)
      data = template(File.expand_path(include_path))
      File.open(save_to, 'w') do |file|
        file.write(data)
      end
    end

    def next_file(config_file)
      path = File.dirname(config_file)
      File.join(path, ".next.#{name}")
    end

    def dottie
      File.join(DOTTIES_DOTS, name)
    end

    def save!
      link(dottie, configs.first) unless configs.empty?
      link_home(dottie)
      configs.each_index do |follower_index|
        follower = configs[follower_index]
        leader = configs[follower_index + 1]
        if leader
          link(next_file(follower), leader)
        end
      end
    end
  end
end
