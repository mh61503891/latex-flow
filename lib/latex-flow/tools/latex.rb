require 'latex-flow/tools/generic'
require 'highline'

module LatexFlow
  class Tools::LaTeX < Tools::Generic

    def initialize(command)
      super(command)
    end

    def messages_with_color
      messages.dup.tap do |m|
        m.gsub!(/\A.+$/, HighLine.new.color('\0', :green))
        m.gsub!(/^Document Class:/ , HighLine.new.color('\0', :green))
        m.gsub!(/^LaTeX Font Warning:/, HighLine.new.color('\0', :yellow))
        m.gsub!(/^(LaTeX Warning)(: Citation)/, HighLine.new.color('\1', :yellow) + '\2')
        m.gsub!(/^(LaTeX Warning)(: Reference)/, HighLine.new.color('\1', :yellow) + '\2')
        m.gsub!(/^(LaTeX Warning)(: Label\(s\))/, HighLine.new.color('\1', :yellow) + '\2')
        m.gsub!(/^No file .+\.bbl\./,  HighLine.new.color('\0', :red))
        m.gsub!(/^(LaTeX Warning:)( There were undefined references\.)/, HighLine.new.color('\1', :red) + '\2')
        m.gsub!(/^! LaTeX Error:/, HighLine.new.color('\0', :red))
        # platex
        m.gsub!(/^warning:/, HighLine.new.color('\0', :yellow))
      end
    end

    def next?
      stdout =~ /LaTeX Warning: Label\(s\) may have changed\./
    end

    def need_bibtex?
      return true if stdout =~ /No file .+?\.bbl/
      return true if messages =~ /^LaTeX Warning: Citation/
      return true if messages =~ /^LaTeX Warning: Label\(s\) may have changed\./
      return false
    end

  end
end
