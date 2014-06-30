require 'latex-flow/cli/generic'

module LatexFlow
  class CLI::Build < CLI::Generic

    def run
      @options[:auto] ? auto_build : build
    end

    def build
      task
    end

    def auto_build
      require 'watchr'
      require 'digest/md5'

      @executor = Class.new {
        def submit(path, &task)
          current_hash = Digest::MD5.file(path).to_s
          @hashes ||= {}
          if @hashes[path] != current_hash
            task.call()
            @hashes[path] = current_hash
          end
        end
      }.new

      script = Watchr::Script.new
      script.watch('.*\.tex|.*\.bib') do |m|
        @executor.submit(m[0]) do
          task
        end

      end
      Watchr::Controller.new(script, Watchr.handler.new).run
    end

    def task
      (@options['latex-max-count']).times do
        # latex
        require 'latex-flow/tools/latex'
        latex = Tools::LaTeX.new("#{ENV.fetch('LATEX', 'latex -halt-on-error')} #{@options[:target]}")
        latex.run
        $stderr.puts latex.messages(color:@options[:color]) if @options[:verbose]
        return if !latex.success?
        # bibtex
        if use_bibtex? && latex.need_bibtex?
          require 'latex-flow/tools/bibtex'
          bibtex = Tools::BibTeX.new("#{ENV.fetch('BIBTEX', 'bibtex')} #{@options[:target]}")
          bibtex.run
          $stderr.puts bibtex.messages(color:@options[:color]) if @options[:verbose]
          return if !bibtex.success?
          next
        else
          break if !latex.next?
        end
      end

      # dvipdfm
      require 'latex-flow/tools/dvipdfm'
      dvipdfm = Tools::Dvipdfm.new("#{ENV.fetch('DVIPDFM', 'dvipdfm')} #{@options[:target]}")
      dvipdfm.run
      $stderr.puts dvipdfm.messages(color:@options[:color]) if @options[:verbose]
      return if !dvipdfm.success?


      # # latex
      # require 'latex-flow/tools/latex'
      # latex = Tools::LaTeX.new("#{ENV.fetch('LATEX', 'latex -halt-on-error')} #{@options[:target]}")
      # latex.run
      # $stderr.puts latex.messages(color:@options[:color]) if @options[:verbose]
      # return if !latex.success?


      # # bibtex
      # if use_bibtex?
      #   require 'latex-flow/tools/bibtex'
      #   bibtex = Tools::BibTeX.new("#{ENV.fetch('BIBTEX', 'bibtex')} #{@options[:target]}")
      #   bibtex.run
      #   $stderr.puts bibtex.messages(color:@options[:color]) if @options[:verbose]
      #   return if !bibtex.success?
      # end

      # # latex(loop)
      # if latex.next?
      #   (@options['latex-max-count']-2).times do
      #     require 'latex-flow/tools/latex'
      #     latex = Tools::LaTeX.new("#{ENV.fetch('LATEX', 'latex -halt-on-error')} #{@options[:target]}")
      #     latex.run
      #     $stderr.puts latex.messages(color:@options[:color]) if @options[:verbose]
      #     return if !latex.success?
      #     latex.next? ? next : break
      #   end
      # end

      # dvipdfm

    end

    def latex
      require 'latex-flow/tools/latex'
      latex = Tools::LaTeX.new("#{ENV.fetch('LATEX', 'latex -halt-on-error')} #{@options[:target]}")
      latex.run
      $stderr.puts latex.messages(color:@options[:color]) if @options[:verbose]
      latex.success?
    end

    def bibtex
      require 'latex-flow/tools/bibtex'
      bibtex = Tools::BibTeX.new("#{ENV.fetch('BIBTEX', 'bibtex')} #{@options[:target]}")
      bibtex.run
      $stderr.puts bibtex.messages(color:@options[:color]) if @options[:verbose]
      bibtex.success?
    end

    def dvipdfm
      require 'latex-flow/tools/dvipdfm'
      dvipdfm = Tools::Dvipdfm.new("#{ENV.fetch('DVIPDFM', 'dvipdfm')} #{@options[:target]}")
      dvipdfm.run
      $stderr.puts dvipdfm.messages(color:@options[:color]) if @options[:verbose]
      dvipdfm.success?
    end

    def use_bibtex?
      @use_bibtex ||= !File.read(@options[:target] + '.tex').scan(/(^[^%\n]*?\\bibliography\{.+?\}.*$)/).flatten.empty?
    end

  end
end
