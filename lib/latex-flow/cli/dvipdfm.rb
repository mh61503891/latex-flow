require 'latex-flow/cli/generic'
require 'latex-flow/tools/dvipdfm'

module LatexFlow
  class CLI::Dvipdfm < CLI::Generic

    def run
      t = Tools::Dvipdfm.new("#{ENV.fetch('DVIPDFM', 'dvipdfm')} #{@options[:target]}")
      t.run
      $stderr.puts t.messages(color:@options[:color]) if @options[:verbose]
      exit(false) if !t.success?
    end

  end
end
