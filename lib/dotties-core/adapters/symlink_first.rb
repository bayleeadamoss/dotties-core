module Adapters
  class SymlinkFirst
    attr_accessor :links

    def initialize
      self.links = {}
    end

    def push(path)
      base_name = File.basename(path)
      links[base_name] = links[base_name] || path
    end

    def save!
      links.each do |base_name, path|
        link = File.join('configs', base_name)
        File.symlink?(link) && File.delete(link)
        File.symlink(path, link)
      end
    end
  end
end
