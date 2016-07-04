module Formats
  class Zshrc < Adapters::Require
    def template(path)
      %{
        [[ -f #{path} ]] && source #{path}
      }
    end
  end
end
