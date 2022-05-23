require 'asciidoctor'
require 'asciidoctor/pdf_renderer'
require 'asciidoctor/theme_loader'
require 'asciidoctor-pdf/implicit_header_processor'

module Documentation
  # decorates each resource with
  # documentation specific logic
  module Document
    def title
      metadata[:page]['title']
    end

    def pdf
      metadata[:pdf]
    end

    def pdf_name
      File.basename(pdf.path)
    end

    def sections
      Hash[metadata[:sections]] if metadata[:sections]
    end

    def render(opts={}, locs={}, &block)
      super(opts.merge(:layout => "doc_layout.erb"), locs, &block)
    end
  end

  class Store < Middleman::Sitemap::Store
    def initialize(app, extension)
      @extension = extension
      @docs = []
      @pdfs = []
      super(app)
    end

    def all
      @docs
    end

    def manipulate_resource_list(resources)
      @docs, @pdfs = [], []

      resources.each do |resource|
        path = resource.source_file

        next unless path.present? && File.extname(path) == '.adoc' && File.dirname(path) =~ /\/docs$/

        work_dir, asciidoc_file = File.split path
        relative_dir = File.basename(work_dir)

        resource.extend Document

        options = {
          :safe => :safe,
          :attributes => @app.config[:asciidoc][:attributes] + %w(idprefix=@ listing-caption=Listing@ buildfor-editor)
        }

        options[:extensions_registry] = Asciidoctor::Extensions.build_registry :pdf do
          include_processor Asciidoctor::Pdf::ImplicitHeaderProcessor.new @document
        end

        file_rootname = Asciidoctor::Helpers.rootname File.basename(asciidoc_file)
        pdf_file = "#{file_rootname}.pdf"

        theme = Asciidoctor::ThemeLoader.load_file(File.join(@app.root, 'pdf-theme.yml'))

        # render the asciidoc
        doc = Asciidoctor.load_file path, options
        doc.restore_attributes

        # build the .pdf file
        Asciidoctor::PdfRenderer.render doc, File.join(work_dir, pdf_file), theme 

        # add pdf to sitemap
        pdf_resource = Middleman::Sitemap::Resource.new(
          self, File.join(relative_dir, pdf_file), path.sub(/.adoc$/, '.pdf')
        )
        @pdfs << pdf_resource

        # used for link helpers
        resource.add_metadata :pdf => pdf_resource
        resource.add_metadata :sections => doc.sections.map { |s| [s.id, s.title] }

        @docs << resource
      end

      # return modified + new pdf resources
      @pdfs + resources
    end
  end

  module Helper
    attr_accessor :documentation

    def docs
      documentation.all
    end
  end

  class Extension < Middleman::Extension
    self.defined_helpers = [Helper]

    option :source, "./source/docs"

    helpers do
    end

    def initialize(app, options_hash={}, &block)
      super

      app.before do
        app.config[:asciidoc][:base_dir] = options_hash[:source] || 'source/docs'
      end
    end

    def after_configuration
      app.documentation = Store.new(app, self)
      app.sitemap.register_resource_list_manipulator(:documentation, app.documentation, 0)
    end
  end
end

::Middleman::Extensions.register(:documentation, Documentation::Extension)
