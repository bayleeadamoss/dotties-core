module Formats
  class Gitconfig < Adapters::Chain
    def template(path)
      %{
        [include]
          path = #{path}
      }
    end
  end
end
