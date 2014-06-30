require 'latex-flow/cli/generic'

module LatexFlow
  class CLI::Archive < CLI::Generic

    def run
      require 'rake/packagetask'
      tag = @options[:tag]
      version = Time.new.to_i.to_s
      Rake::PackageTask.new(tag, version) do |p|
        p.package_dir = "./archives"
        p.package_files.include("**")
        p.package_files.exclude('archives')
        p.need_zip = true
      end
      Rake::Task[:package].invoke
    end

  end
end
