class Package

  attr_accessor :name, :config

  ROOT = './components'

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
    File.join(ROOT, name.gsub('/', '-'))
  end

  def files
    []
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

  def exists?
    installed? || open("https://api.github.com/repos/#{name}/stats/commit_activity")
    true
  rescue
    false
  end
end
