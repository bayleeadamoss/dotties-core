class Merger
  attr_accessor :name, :data
  def initialize
    self.data = []
  end

  def likes?(base)
    base == name.match(/\.(.*)/)[1]
  end

  def save!
    f = File.new(name, 'w')
    f.write(data.join("\n"))
    f.close
  end
end

class Tmux < Merger
  def initialize
    super
    self.name = '.tmux.conf'
  end

  def push(path)
    data << %{
      if-shell "[ -f #{path} ]" 'source #{path}'
    }
  end
end

class Vim < Merger
  def initialize
    super
    self.name = '.vimrc'
  end

  def push(path)
    data << %{
      if filereadable(expand("#{path}"))
        source #{path}
      endif
    }
  end
end

class VimBundles < Vim
  def initialize
    super
    self.name = '.vimrc.bundles'
  end
end

class GitConfig
  attr_accessor :configs, :name

  def initialize
    self.configs = []
    self.name = '.gitconfig'
  end

  def likes?(base)
    base == name.match(/\.(.*)/)[1]
  end

  def push(path)
    self.configs << path
  end

  def link(save_to, include_path)
    data = %{
      [include]
        path = #{File.absolute_path(include_path)}
    }
    f = File.new(save_to, 'w')
    f.write(data)
    f.close
  end

  def next_file(config_file)
    path = File.dirname(config_file)
    File.join(path, ".next#{name}")
  end

  def save!
    link(name, configs.first)
    configs.each_index do |follower_index|
      follower = configs[follower_index]
      leader = configs[follower_index + 1]
      if leader
        link(next_file(follower), leader)
      end
    end
  end
end

class UnknownFormat
  attr_accessor :links

  def initialize
    self.links = {}
  end

  def likes?(base)
    true
  end

  # Uses the first one only for each file name
  def push(path)
    base_name = File.basename(path)
    links[base_name] = links[base_name] || path
  end

  def save!
    links.each do |base_name, path|
      link = ".#{base_name}"
      File.symlink?(link) && File.delete(link)
      File.symlink(path, link)
    end
  end
end

class Dotties
  attr_accessor :files, :adapters
  def initialize
    self.files = []
    self.adapters = [
      GitConfig.new,
      Tmux.new,
      Vim.new,
      VimBundles.new,
      UnknownFormat.new,
    ]
  end

  def push(file_name)
    base_name = File.basename(file_name)
    adapters.detect { |adapter|
      adapter.likes?(base_name)
    }.push(file_name)
  end

  def save!
    adapters.each do |adapter|
      adapter.save!
    end
  end
end

# RUNNNNN
root = "./components"
dotties = Dotties.new
Dir.entries(root).select { |component|
  !component.match(/^\./)
}.each { |component|
  Dir.entries(File.join(root, component)).select { |file|
    !file.match(/^\./)
  }.each { |file|
    p File.join(root, component, file)
    dotties.push(File.join(root, component, file))
  }
}
dotties.save!
