require 'latex-flow/cli/generic'
require 'rake/clean'

module LatexFlow
  class CLI::Clean < CLI::Generic

  	# TODO: support verbose
    def run
      CLEAN.include(%w{aux log dvi bbl blg toc lof lot fdb_latexmk fls out bb xbb DS_Store}.map{|e|"**/*.#{e}"})
      Rake::Task[:clean].execute
    end

  end
end
