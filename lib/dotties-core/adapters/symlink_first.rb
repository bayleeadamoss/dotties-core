module Adapters
  class SymlinkFirst < Core
    attr_accessor :links

    def initialize
      @links = {}
    end

    def push(path)
      base_name = File.basename(path)
      links[base_name] = links[base_name] || path
    end

    def save!
      links.each do |base_name, path|
        link = File.join(DOTTIES_DOTS, base_name)
        File.symlink?(link) && File.delete(link)
        File.symlink(File.expand_path(path), link)
        link_home(link)
      end
    end
  end
end
