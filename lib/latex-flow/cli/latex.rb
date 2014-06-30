require 'latex-flow/cli/generic'
require 'latex-flow/tools/latex'

module LatexFlow
  class CLI::LaTeX < CLI::Generic

    def run
      t = Tools::LaTeX.new("#{ENV.fetch('LATEX', 'latex -halt-on-error')} #{@options[:target]}")
      t.run
      $stderr.puts t.messages(color:@options[:color]) if @options[:verbose]
      exit(false) if !t.success?
    end

  end
end
