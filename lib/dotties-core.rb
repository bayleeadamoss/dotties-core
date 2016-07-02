require 'pry'

require_relative './dotties-core/adapters/chain'
require_relative './dotties-core/adapters/require'
require_relative './dotties-core/adapters/symlink_first'

require_relative './dotties-core/formats/gitconfig'
require_relative './dotties-core/formats/tmux_conf'
require_relative './dotties-core/formats/vimrc'
require_relative './dotties-core/formats/unknown_format'

require_relative './dotties-core/controller'
require_relative './dotties-core/dotties-cli'
require_relative './dotties-core/dotties'
