# -*- encoding: utf-8 -*-
# stub: asciidoctor-pdf 1.0.0.dev ruby lib

Gem::Specification.new do |s|
  s.name = "asciidoctor-pdf".freeze
  s.version = "1.0.0.dev"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["OpenDevise Inc.".freeze]
  s.date = "2022-03-30"
  s.description = "An extension for Asciidoctor that converts AsciiDoc documents to PDF files using the Prawn PDF generator.\n".freeze
  s.email = "dan@opendevise.io".freeze
  s.executables = ["asciidoctor-pdf".freeze, "optimize-pdf".freeze]
  s.extra_rdoc_files = ["README.adoc".freeze, "LICENSE.adoc".freeze, "NOTICE.adoc".freeze]
  s.files = ["LICENSE.adoc".freeze, "NOTICE.adoc".freeze, "README.adoc".freeze, "bin/asciidoctor-pdf".freeze, "bin/optimize-pdf".freeze, "data/fonts/LICENSE-liberation-fonts-2.00.1".freeze, "data/fonts/LICENSE-mplus-testflight-58".freeze, "data/fonts/LICENSE-noto-fonts-2014-01-30".freeze, "data/fonts/liberationmono-bold-latin.ttf".freeze, "data/fonts/liberationmono-bolditalic-latin.ttf".freeze, "data/fonts/liberationmono-italic-latin.ttf".freeze, "data/fonts/liberationmono-regular-latin.ttf".freeze, "data/fonts/mplus1mn-bold-ascii.ttf".freeze, "data/fonts/mplus1mn-bolditalic-ascii.ttf".freeze, "data/fonts/mplus1mn-italic-ascii.ttf".freeze, "data/fonts/mplus1mn-regular-ascii-conums.ttf".freeze, "data/fonts/mplus1p-bold-latin.ttf".freeze, "data/fonts/mplus1p-light-latin.ttf".freeze, "data/fonts/mplus1p-regular-latin.ttf".freeze, "data/fonts/mplus1p-regular-multilingual.ttf".freeze, "data/fonts/notoserif-bold-latin.ttf".freeze, "data/fonts/notoserif-bolditalic-latin.ttf".freeze, "data/fonts/notoserif-italic-latin.ttf".freeze, "data/fonts/notoserif-regular-latin.ttf".freeze, "data/templates/inline_anchor.html.slim".freeze, "data/templates/inline_button.html.slim".freeze, "data/templates/inline_footnote.html.slim".freeze, "data/templates/inline_kbd.html.slim".freeze, "data/templates/inline_menu.html.slim".freeze, "data/templates/inline_quoted.html.slim".freeze, "data/themes/asciidoctor-theme.yml".freeze, "data/themes/default-theme.yml".freeze, "examples/chronicles.adoc".freeze, "examples/chronicles.pdf".freeze, "examples/example-pdf-screenshot.png".freeze, "examples/example.adoc".freeze, "examples/example.pdf".freeze, "examples/sample-title-logo.jpg".freeze, "examples/wolpertinger.jpg".freeze, "lib/asciidoctor-pdf/implicit_header_processor.rb".freeze, "lib/asciidoctor-pdf/version.rb".freeze, "lib/asciidoctor/core_ext/array.rb".freeze, "lib/asciidoctor/ext/section.rb".freeze, "lib/asciidoctor/pdf_renderer.rb".freeze, "lib/asciidoctor/prawn.rb".freeze, "lib/asciidoctor/prawn/coderay_encoder.rb".freeze, "lib/asciidoctor/prawn/extensions.rb".freeze, "lib/asciidoctor/prawn/formatted_text/formatter.rb".freeze, "lib/asciidoctor/prawn/formatted_text/parser.rb".freeze, "lib/asciidoctor/prawn/formatted_text/parser.treetop".freeze, "lib/asciidoctor/prawn/formatted_text/transform.rb".freeze, "lib/asciidoctor/theme_loader.rb".freeze, "lib/roman_numeral.rb".freeze]
  s.homepage = "https://github.com/asciidoctor/asciidoctor-pdf".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8 --title=\"Asciidoctor PDF\" --main=README.adoc -ri".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Converts AsciiDoc documents to PDF files using Prawn".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_runtime_dependency(%q<asciidoctor>.freeze, [">= 1.5.0.rc.2", "< 1.6.0"])
    s.add_runtime_dependency(%q<coderay>.freeze, ["= 1.1.0"])
    s.add_runtime_dependency(%q<prawn>.freeze, ["= 1.0.0"])
    s.add_runtime_dependency(%q<prawn-templates>.freeze, ["= 0.0.3"])
    s.add_runtime_dependency(%q<prawn-svg>.freeze, ["= 0.16.0"])
    s.add_runtime_dependency(%q<slim>.freeze, ["~> 2.0.0"])
    s.add_runtime_dependency(%q<thread_safe>.freeze, ["= 0.3.4"])
    s.add_runtime_dependency(%q<tilt>.freeze, [">= 1.4.1", "< 2.1.0"])
    s.add_runtime_dependency(%q<treetop>.freeze, ["= 1.5.3"])
  else
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<asciidoctor>.freeze, [">= 1.5.0.rc.2", "< 1.6.0"])
    s.add_dependency(%q<coderay>.freeze, ["= 1.1.0"])
    s.add_dependency(%q<prawn>.freeze, ["= 1.0.0"])
    s.add_dependency(%q<prawn-templates>.freeze, ["= 0.0.3"])
    s.add_dependency(%q<prawn-svg>.freeze, ["= 0.16.0"])
    s.add_dependency(%q<slim>.freeze, ["~> 2.0.0"])
    s.add_dependency(%q<thread_safe>.freeze, ["= 0.3.4"])
    s.add_dependency(%q<tilt>.freeze, [">= 1.4.1", "< 2.1.0"])
    s.add_dependency(%q<treetop>.freeze, ["= 1.5.3"])
  end
end
