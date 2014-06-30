require 'thor'

module LatexFlow

  class CLI < Thor

    class_option :verbose, type:'boolean', banner:'Enable verbose output mode', aliases:'-V'
    class_option :color, type:'boolean', banner:'Enable color output mode', aliases:'-C'

    desc 'version', 'Show LatexFlow\'s version information'
    def version
      require 'latex-flow/cli/version'
      CLI::Version.new(options).run
    end
    map %w(-v --version) => :version

    desc 'clean', 'Remove any temporary files'
    def clean
      require 'latex-flow/cli/clean'
      CLI::Clean.new(options).run
    end

    desc 'archive TAG', "Archive files into ./archives/#{Time.new.to_i}-[TAG].zip"
    def archive(tag)
      require 'latex-flow/cli/archive'
      CLI::Archive.new(options.merge(tag:tag)).run
    end

    desc 'archives', 'Show a list of archives in ./archives/'
    def archives
      require 'latex-flow/cli/archives'
      CLI::Archives.new(options).run
    end

    desc 'latex TARGET [OPTIONS]', 'Execute the latex command'
    def latex(target)
      require 'latex-flow/cli/latex'
      CLI::LaTeX.new(options.merge({target:target})).run
    end

    desc 'bibtex TARGET [OPTIONS]', 'Execute the bibtex command'
    def bibtex(target)
      require 'latex-flow/cli/bibtex'
      CLI::BibTeX.new(options.merge({target:target})).run
    end

    desc 'dvipdfm TARGET [OPTIONS]', 'Execute the dvipdfm command'
    def dvipdfm(target)
      require 'latex-flow/cli/dvipdfm'
      CLI::Dvipdfm.new(options.merge({target:target})).run
    end

    desc 'build TARGET [OPTIONS]', 'Build a pdf file'
    method_option :auto, type:'boolean'
    method_option 'latex-max-count', type:'numeric', banner:'<count>', default:5
    def build(target)
      require 'latex-flow/cli/build'
      CLI::Build.new(options.merge({target:target})).run
    end

    # TODO
    # desc 'info [OPTIONS]', 'Show information of the LaTeX\'s project'
    # def info
    # end

    # TODO
    # desc 'new NAME [OPTIONS]', 'Create a new LaTeX\'s project from a template specified by NAME'
    # def new(name)
    # end

    # TODO
    # desc 'searh QUERY [OPTIONS]', 'Search and Display LaTeX\'s templates by QUERY on remote repositories'
    # def search(query)
    # end

  end
end
