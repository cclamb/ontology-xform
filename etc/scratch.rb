require 'nokogiri'

class Dispatcher < Nokogiri::XML::SAX::Document

  def start_element name, attributes
    puts "<=== Name: #{name} started ===>\n"
  end

  def error msg
    puts "++++ Holy Smokes Batman! #{msg}\n"
  end

end

def process_element clz
  
  puts "Attributes: #{clz.attributes.size}\n"
  clz.attributes.each do |key, value|
    puts "\t<#{key}, #{value}>\n"
  end

  puts "Elements: #{clz.children.size}\n"
  clz.children.each do |child|
    puts "--- <#{child.name}> ---\n"
    process_element child
    puts "--- end <#{child.name}> ---\n"
  end
  
end

def process_doc doc
  clz = doc.xpath '//owl:Class'
  clz.each do |clz|
    puts "\n\n<=== Begin Class <#{clz.name}> ===>"
    process_element clz
    puts "<=== End Class <#{clz.name} ===>"
  end
end

xml = File.read 'simple-ontology.owl'

doc = Nokogiri::XML xml

process_doc doc

#sax = Nokogiri::XML::SAX::Parser.new Dispatcher.new

#doc.namespaces.each do |k,v|
#  puts "<#{k}, #{v}>\n"
#end

#sax.parse(doc.to_xml) do |ctx|
#  ctx.replace_entities = false
#end