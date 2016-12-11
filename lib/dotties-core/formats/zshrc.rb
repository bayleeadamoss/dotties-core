module Formats
  class Zshrc < Adapters::Require
    def template(path)
%{#!/usr/bin/env bash
if [ -f #{path} ] 
then
    source #{path}
fi 
}
    end
  end
end
