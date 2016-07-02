class DottiesCli
  attr_accessor :command, :option

  def initialize(command = nil, option = nil)
    @command = command || :help
    @option = option
  end

  def run!
    Controller.new.send(@command, @option)
  end
end
