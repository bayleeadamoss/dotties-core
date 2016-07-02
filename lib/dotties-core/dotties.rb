require 'open-uri'
require 'fileutils'

class Dotties
  attr_accessor :files, :formats

  def initialize
    self.files = []
    self.formats = [
      Formats::Gitconfig.new,
      Formats::TmuxConf.new,
      Formats::Vimrc.new,
      Formats::UnknownFormat.new,
    ]
  end

  def install(package)
    if package_exists?(package)
      root = "./components"
      folder = package.gsub('/', '-')
      `git clone https://github.com/#{package}.git #{File.join(root, folder)}`
      File.open('.dotties.yml', 'a') do |file|
        file.puts("  - #{package}")
      end
      update
    else
      puts "Package '#{package}' does not exist on github."
    end
  end

  def uninstall(package)
    root = "./components"
    folder = package.gsub('/', '-')

    output = File.open('.dotties.yml', 'r').reject do |input|
      input.match(package)
    end

    File.open('.dotties.yml', 'w+') do |file|
      file.write(output.join)
    end

    FileUtils.remove_entry_secure(File.join(root, folder))
    update
  end

  def update
    component_files.each do |file_name|
      base_name = File.basename(file_name)
      formats.detect { |adapter|
        adapter.likes?(base_name)
      }.push(file_name)
    end
    formats.each(&:save!)
  end

  protected

  def package_exists?(package)
    open("https://api.github.com/repos/#{package}/stats/commit_activity")
    true
  rescue
    false
  end

  def components
    root = "./components"
    Dir.entries(root).select do |component|
      !component.match(/^\./)
    end
  end

  def component_files
    root = "./components"
    components.reduce([]) do |memo, component|
      Dir.entries(File.join(root, component)).each do |file|
        memo << File.join(root, component, file) if !file.match(/^\./)
      end
      memo
    end
  end
end
