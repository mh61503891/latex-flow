require 'latex-flow/cli/generic'
require 'latex-flow/tools/bibtex'

module LatexFlow
  class CLI::BibTeX < CLI::Generic

    def run
      t = Tools::BibTeX.new("#{ENV.fetch('BIBTEX', 'bibtex')} #{@options[:target]}")
      t.run
      $stderr.puts t.messages(color:@options[:color]) if @options[:verbose]
      exit(false) if !t.success?
    end

  end
end
