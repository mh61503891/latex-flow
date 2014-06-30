require 'latex-flow/tools/generic'
require 'highline'

module LatexFlow
  class Tools::BibTeX < Tools::Generic

    def initialize(command)
      super(command)
    end

    def messages_with_color
      messages.dup.tap do |m|
        m.gsub!(/\A.+$/, HighLine.new.color('\0', :green))
        m.gsub!(/^Warning/, HighLine.new.color('\0', :yellow))
        m.gsub!(/(There were \d+ warnings)/, HighLine.new.color('\0', :red))
        # for pBibTex
        m.gsub!(/(There were \d+ error messages)/, HighLine.new.color('\0', :red))
      end
    end

  end
end
