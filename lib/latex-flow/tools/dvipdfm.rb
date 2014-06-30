require 'latex-flow/tools/generic'
require 'highline'

module LatexFlow
  class Tools::Dvipdfm < Tools::Generic

    def initialize(command)
      super(command)
    end

    def messages_with_color
      messages.dup.tap do |m|
        m.gsub!(/.* -> .*/, HighLine.new.color('\0', :green))
        m.gsub!(/\*\* ERROR \*\*/, HighLine.new.color('\0', :red))
      end
    end

  end
end
