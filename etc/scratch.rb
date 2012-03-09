require_relative '../lib/flounder/parser'

include Flounder

filename = 'simple-ontology.owl'

p = Parser.new
xml = File.read filename
r = p.parse xml
#puts "#{r[:structure]}\n\n#{r[:elements]}\n\n"

elements = r[:elements]
structure = r[:structure]

elements.each do |k,v|
  superclazz = structure[k.to_sym]
  print "#{k}"
  print " : #{superclazz}" unless superclazz == nil
  print "\n\n"
  print "#{v}\n\n"
end