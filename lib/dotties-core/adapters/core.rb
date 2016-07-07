module Adapters
  class Core
    def link_home(current_file)
      symlink_file = File.join(DOTTIES_HOME, ".#{File.basename(current_file)}")
      File.symlink?(symlink_file) && File.delete(symlink_file)
      File.symlink(current_file, symlink_file)
    end
  end
end
