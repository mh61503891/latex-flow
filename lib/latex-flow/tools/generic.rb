require 'systemu'

module LatexFlow
  module Tools
    class Generic

      attr_reader :command, :process, :stdout, :stderr

      def initialize(command)
        @command = command
      end

      def run
        @process, @stdout, @stderr = systemu(@command)
      end

      def success?
        @process.success?
      end

      def stdout
        @stdout
      end

      def stdout_with_color
        @stdout
      end

      def stderr
        @stderr
      end

      def stderr_with_color
        @stderr
      end

      def messages(color:false)
        color ? messages_with_color : @stdout + $/ + @stderr
      end

      def messages_with_color
        @stdout + $/ + @stderr
      end

    end
  end
end
