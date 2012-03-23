require_relative '../lib/flounder/parser'
require_relative '../lib/flounder/rectifier'

include Flounder

def get_class_name e
  e[0].split('#').last
end

#filename = 'Ontology2.owl'
filename = 'Ontology.owl'
#filename = 'simple-ontology.owl'

p = Parser.new
xml = File.read filename
r = p.parse xml
rectifier = Rectifier.new
od = rectifier.rectify r[:elements], r[:structure]
puts od