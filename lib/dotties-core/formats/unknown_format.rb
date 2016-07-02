module Formats
  class UnknownFormat < Adapters::SymlinkFirst
    def likes?(base)
      true
    end
  end
end
