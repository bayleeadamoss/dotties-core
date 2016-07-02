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
  end

  def uninstall(package)
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
