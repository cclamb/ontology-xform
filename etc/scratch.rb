require_relative '../lib/flounder/parser'
require_relative '../lib/flounder/module_generator'
require_relative '../lib/flounder/class_generator'

include Flounder

filename = 'Ontology.owl'#'simple-ontology.owl'

p = Parser.new
xml = File.read filename
r = p.parse xml
#puts "#{r[:structure]}\n\n#{r[:elements]}\n\n"

elements = r[:elements]
structure = r[:structure]

module_elements = {}
elements.each do |k, v|
  clazz = ClassGenerator.new do |ctx|
    ctx.name = k.to_s
    #ctx.parent = v.to_s unless v == nil
  end
  module_elements[k.to_sym] = clazz
end

new_elements = []
structure.each do |k,v|
  clazz = module_elements[k]
  unless clazz == nil
    clazz.parent = module_elements[v]
    new_elements.push clazz.parent unless new_elements.include? clazz.parent
  end
  new_elements.push clazz
end

mod = ModuleGenerator.new do |ctx|
  ctx.elements = new_elements #module_elements.values
  ctx.name = 'SomeMod'
end

str = ''
mod.generate str

str = str.gsub! /#|\/|:|\./, '_' 

puts str

#Object.new.instance_eval str


