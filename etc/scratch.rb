require 'nokogiri'

def process_element(clz)
  
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

xml = File.read 'simple-ontology.owl'
doc = Nokogiri::XML xml
clz = doc.xpath '//owl:Class'
clz.each do |clz|
  puts "\n\n<=== Begin Class <#{clz.name}> ===>"
  process_element clz
  puts "<=== End Class <#{clz.name} ===>"
end