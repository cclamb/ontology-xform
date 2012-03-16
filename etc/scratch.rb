require_relative '../lib/flounder/parser'
require_relative '../lib/flounder/module_generator'
require_relative '../lib/flounder/class_generator'

include Flounder

filename = 'Ontology2.owl'
#filename = 'Ontology.owl'
#filename = 'simple-ontology.owl'

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

def find_parent clazz, catalog, structure
  return [] if clazz == nil
  #puts clazz.name
  parent_name = structure[clazz.name.to_sym]
  #puts "pname : #{parent_name}"
  return [] if parent_name == nil
  parent = catalog[parent_name]
  clazz.parent = parent
  return [parent] + find_parent(parent, catalog, structure)
end

new_elements = []
structure.each do |k,v|
  clazz = module_elements[k]
  elems = find_parent clazz, module_elements, structure
  elems = [clazz] + elems
  elems.reverse.each do |x|
    new_elements.push x unless new_elements.include? x
  end
end

# structure.each do |k,v|
#   clazz = module_elements[k]
#   elems = [clazz] + find_parent(clazz, module_elements, structure)
#   elems.each do |x|
#     new_elements.push x unless new_elements.include? x
#   end
  # unless clazz == nil
  #   clazz.parent = module_elements[v]
  #   new_elements.push clazz.parent unless new_elements.include? clazz.parent
  # end
  # new_elements.push clazz
#end

mod = ModuleGenerator.new do |ctx|
  ctx.elements = new_elements #module_elements.values
  ctx.name = 'SomeMod'
end

str = ''
mod.generate str

str = str.gsub! /#|\/|:|\./, '_' 

puts str

Object.new.instance_eval str


