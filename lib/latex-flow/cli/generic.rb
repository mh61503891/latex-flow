module LatexFlow
  class CLI::Generic

    def initialize(options={})
      @options = options
    end

    def run
      raise NotImplementedError
    end

  end
end
