require_relative '../lib/flounder/parser'
require_relative '../lib/flounder/module_generator'
require_relative '../lib/flounder/class_generator'

include Flounder

filename = 'simple-ontology.owl'

p = Parser.new
xml = File.read filename
r = p.parse xml
puts "#{r[:structure]}\n\n#{r[:elements]}\n\n"

elements = r[:elements]
structure = r[:structure]

# elements.each do |k,v|
#   superclazz = structure[k.to_sym]
#   print "#{k}"
#   print " : #{superclazz}" unless superclazz == nil
#   print "\n\n"
#   print "#{v}\n\n"
# end

# order elements

module_elements = {}
elements.each do |k, v|
  clazz = ClassGenerator.new do |ctx|
    ctx.name = k.to_s
    #ctx.parent = v.to_s unless v == nil
  end
  module_elements[k.to_sym] = clazz
end

structure.each do |k,v|
  clazz = module_elements[k]
  clazz.parent = module_elements[v] unless clazz == nil
end

mod = ModuleGenerator.new do |ctx|
  ctx.elements = module_elements.values
  ctx.name = 'SomeMod'
end

str = ''
mod.generate str

str = str.gsub! /#|\/|:|\./, '_' 

#puts str

#Object.new.instance_eval str


