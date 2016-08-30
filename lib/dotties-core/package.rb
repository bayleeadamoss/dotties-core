class Package

  attr_accessor :name, :config

  def initialize(name)
    @name = name
    @config = ConfigFile.new(config_path)
  end

  def dependencies
    @config.get(:packages, [])
  end

  def config_path
    File.join(folder_path, '.dotties.yml')
  end

  def folder_path
    File.join(DOTTIES_PACKAGES, name.gsub('/', '-'))
  end

  def files
    Dir.entries(folder_path).select { |file|
      is_hidden = file.match(/^\./)
      is_ignored = config.get(:ignore, []).include?(file)
      !is_hidden and !is_ignored
    }.map { |file|
      File.join(folder_path, file)
    }
  end

  def installed?
    File.exists?(folder_path)
  end

  def uninstall!
    FileUtils.remove_entry_secure(folder_path)
  end

  def install!
    `git clone https://github.com/#{name}.git #{folder_path}` unless installed?
  end

  def update!
    `cd #{folder_path} && git pull` if installed?
  end

  def exists?
    installed? || open("https://api.github.com/repos/#{name}/stats/commit_activity")
    true
  rescue
    false
  end
end
