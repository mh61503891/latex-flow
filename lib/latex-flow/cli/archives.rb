require 'latex-flow/cli/generic'

module LatexFlow
  class CLI::Archives < CLI::Generic

    def run
      Dir.glob(File.join('archives', '*.zip')).map{ |archive|
        basename = File.basename(archive)
        time = basename.scan(/\A.+\-(\d+)\..+\Z/).first.first.to_i
        [time, archive]
      }.sort_by{ |time, archive|
        time
      }.each do |time, archive|
        puts "#{Time.at(time.to_i)}\t#{archive}"
      end
    end

  end
end
