require_relative '../lib/flounder/parser'

include Flounder

#filename = 'Ontology2.owl'
filename = 'Ontology.owl'
#filename = 'simple-ontology.owl'

p = Parser.new
xml = File.read filename
r = p.parse xml

elements = r[:elements]

elements.each do |e|
  puts "===\n#{e}\n==="
end