require 'nokogiri'

class Dispatcher < Nokogiri::XML::SAX::Document

  def start_element(name, attributes)
    puts "Name: <#{name}> Attributes: <#{attributes}>\n"
  end

  def error(msg)
    puts "ERROR! ==> #{msg}\n"
  end

end

#parser = Nokogiri::XML::SAX::Parser.new Dispatcher.new
#parser.parse_file 'simple-ontology.owl'
#parser.parse File.read 'simple-ontology.owl'

doc = Nokogiri::XML 'simple-ontology.owl'
doc.remove_namespaces!
puts "#{doc.xpath('//Class').to_s}"