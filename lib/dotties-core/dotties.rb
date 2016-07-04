require 'open-uri'
require 'fileutils'
require 'yaml'

class Dotties
  attr_accessor :files, :formats

  def initialize
    self.files = []
    self.formats = [
      Formats::Gitconfig.new,
      Formats::TmuxConf.new,
      Formats::Vimrc.new,
      Formats::VimrcBundles.new,
      Formats::Zshrc.new,
      Formats::UnknownFormat.new,
    ]
  end

  def install(package_name, root_level_page = true)
    package = Package.new(package_name)
    if package.installed?
      puts "Package '#{package_name}' already installed."
    elsif package.exists?
      package.install!
      package.dependencies.each do |sub_package|
        install(sub_package, false)
      end

      if root_level_page
        ConfigFile.new('.dotties.yml').add(:packages, package.name)
        update_noop
        puts "Package '#{package_name}' installed."
      end
    else
      puts "Package '#{package_name}' does not exist on github."
    end
  end

  def uninstall(package_name, root_level_package = true)
    package = Package.new(package_name)
    if package.installed?
      package.dependencies.each do |sub_package|
        uninstall(sub_package, false)
      end

      package.uninstall!

      if root_level_package
        ConfigFile.new('.dotties.yml').remove(:packages, package)
        update_noop
        puts "Package '#{package_name}' uninstalled."
      end
    end
  end

  def update
    files.each do |file_name|
      base_name = File.basename(file_name)
      formats.detect { |adapter|
        adapter.likes?(base_name)
      }.push(file_name)
    end
    formats.each(&:save!)
  end

  protected

  def update_noop
  end

  def components
    ConfigFile.new('.dotties.yml').get(:packages, [])
  end

  def files
    components.reduce([]) do |memo, component|
      memo + component_files(component)
    end
  end

  def component_files(package_name)
    package = Package.new(package_name)
    [].tap do |files|
      package.dependencies.each do |child|
        files.push(*component_files(child))
      end
      files.push(*package.files)
    end
  end
end
