class Controller
  def method_missing(method, *args)
    if method.to_s == '--version'
      version
    else
      puts "Error: Method '#{method}' not found!"
      help
    end
  end

  def help(option = nil)
    if option
      send(option, '--help')
    else
      [
        "Usage:",
        "  dotties install <package>",
        "  dotties uninstall <package>",
        "  dotties update",
        "  dotties version",
        "  dotties help [<command>]",
      ].each do |line|
        puts line
      end
    end
  end

  def version(option = nil)
    version_file = File.join(DOTTIES_CORE, '.version')
    puts "dotties version #{File.read(version_file).strip}"
  end

  def install(option = nil)
    if not option or option == '--help'
      [
        "dotties install <package>:",
        "  Install a new dotties package.",
        "  <package> is a valid github short url",
      ].each do |line|
        puts line
      end
    else
      Dotties.new.install(option)
    end
  end

  def uninstall(option = nil)
    if not option or option == '--help'
      [
        "dotties uninstall <package>:",
        "  Uninstall a new dotties package.",
        "  <package> is a valid github short url",
      ].each do |line|
        puts line
      end
    else
      Dotties.new.uninstall(option)
    end
  end

  def update(option = nil)
    if option == '--help'
      [
        "dotties update:",
        "  Recreate the links dotties created to link all your dotties.",
      ].each do |line|
        puts line
      end
    else
      Dotties.new.update
    end
  end
end
