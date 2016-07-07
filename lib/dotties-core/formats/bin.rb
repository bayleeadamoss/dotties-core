module Formats
  class Bin < Adapters::SymlinkFirst
    def likes?(base)
      base === 'bin'
    end
  end
end
