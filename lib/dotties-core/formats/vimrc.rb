module Formats
  class Vimrc < Adapters::Require
    def template(path)
      %{
        if filereadable(expand("#{path}"))
          source #{path}
        endif
      }
    end
  end
end
