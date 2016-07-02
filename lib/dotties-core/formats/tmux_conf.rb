module Formats
  class TmuxConf < Adapters::Require
    def template(path)
      %{
        if-shell "[ -f #{path} ]" 'source #{path}'
      }
    end
  end
end
