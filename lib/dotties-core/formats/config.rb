module Formats
  class Config < Adapters::SymlinkNestedFile
    attr_accessor :config_dirs

    def initialize
      @config_dirs = []
    end

    def likes?(file_name)
      file_name == 'config'
    end

    def push(path)
      config_dirs << path
    end

    def save!
      return if config_dirs.empty?
      config_dirs.each do |config_dir|
        walk(config_dir).each do |real_file|
          real_file = Pathname.new(File.expand_path(real_file))
          symlink_file = real_file.relative_path_from(Pathname.new(config_dir))
          symlink_path = File.join(File.expand_path('~/.config'), symlink_file)
          FileUtils.mkdir_p(File.dirname(symlink_path))
          File.symlink?(symlink_path) && File.delete(symlink_path)
          File.symlink(real_file, symlink_path)
        end
      end
    end

    protected

    def walk(start, memo_start = [])
      Dir.foreach(start).reduce(memo_start) do |memo, file|
        path = File.join(start, file)
        if !file.match(/^\./)
          if File.directory?(path)
            walk(path, memo)
          else
            memo << path
          end
        end
        memo
      end
    end
  end
end
