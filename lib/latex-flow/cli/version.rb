require 'latex-flow/cli/generic'
require 'latex-flow/version'

module LatexFlow
  class CLI::Version < CLI::Generic

    def run
      $stderr.puts "LatexFlow version #{LatexFlow::VERSION}"
    end

  end
end
