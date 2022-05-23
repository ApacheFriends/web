require 'yaml'

SOURCE_FILENAME = "./locales/en.yml"

translations = YAML.load_file SOURCE_FILENAME

class Hash
  def smash(prefix = nil)
    inject({}) do |acc, (k, v)|
      key = prefix.to_s + k
      if Hash === v
        acc.merge(v.smash(key + '.'))
      else
        acc.merge(key => v)
      end
    end
  end
end

puts <<EOF
# Loco Gettext template
#, fuzzy
msgid ""
msgstr ""
"Project-Id-Version: en.yml conversion\\n"
"Report-Msgid-Bugs-To: \\n"
"POT-Creation-Date: Wed, 22 Jan 2014 01:45:15 +0000\\n"
"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\\n"
"Last-Translator: FULL NAME <EMAIL@ADDRESS\\n"
"Language-Team: \\n"
"Language: \\n"
"Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\\n"
"MIME-Version: 1.0\\n"
"Content-Type: text/plain; charset=UTF-8\\n"
"Content-Transfer-Encoding: 8bit\\n"
"X-Generator: Loco https://localise.biz\\n"
"X-Poedit-SourceCharset: UTF-8"
EOF

translations.smash.each do |key, element|
  next if key.strip.empty? || (element.is_a?(String) && element.strip.empty?)
  Array(element).each_with_index do |value, i|
    puts "#: #{key + (i > 0 ? '.' + i.to_s : '')}\nmsgid \"#{value}\"\nmsgstr \"\"\n"
  end
end
