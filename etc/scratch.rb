require_relative '../lib/flounder/parser'

include Flounder

filename = 'simple-ontology.owl'

p = Parser.new
xml = File.read filename
r = p.parse xml
#puts "#{r[:structure]}\n\n#{r[:elements]}\n\n"

elements = r[:elements]
structure = r[:structure]

#elements.each do |k,v|
#  superclazz = structure[k.to_sym]
#  print "#{k}"
#  print " : #{superclazz}" unless superclazz == nil
#  print "\n\n"
#  print "#{v}\n\n"
#end

class ModuleGenerator

  attr_accessor :name, :elements

  def initialize
    name = ''
    elements = []
    yield self if block_given?
  end

  def generate str, indent = 0
    indent.times { str << "\t" } ; str << "module #{name}\n"
    elements.each { |e| e.generate str, indent + 1 }
    indent.times { str << "\t" } ; str << "end\n"
  end

end

class MethodGenerator

  attr_accessor :name, :instructions

  def initialize
    name = ''
    instructions = []
    yield self if block_given?
  end

  def generate str, indent = 0
    indent.times { str << "\t" } ; str << "def #{name}\n"
    instructions.each { |i| indent.times { str << "\t" } ; str << "\t#{i}\n" }
    indent.times { str << "\t" }; str << "end\n"
  end

end

class ClassGenerator

  attr_accessor :name, :parent, :included_module

  def initialize
    name = ''
    parent = ''
    included_module = nil
    yield self if block_given?
  end

  def generate str, indent = 0
    puts indent
    indent.times { str << "\t" } ; str << "class #{name}"
    str << " < #{parent}" if parent
    indent.times { str << "\t" } ; str << "\n"
    indent.times { str << "\t" } ; str << "\tinclude #{included_module.name}" if included_module
    str << "\n"
    indent.times { str << "\t" } ; str << "end\n"
  end

end

im = ModuleGenerator.new do |ctx|
  ctx.name = 'Mako'

  m = MethodGenerator.new do |ctx|
    ctx.name = 'print_foo'
    ctx.instructions = ["puts 'foo'"]
  end

  ctx.elements = [m]
end

g = ClassGenerator.new do |ctx|
  ctx.name = 'Name'
  ctx.parent = 'Parent'
  ctx.included_module = im
end

m = ModuleGenerator.new do |ctx|
  ctx.name = 'ModuleName'
  ctx.elements = [im, g]
end

module Foo
  def bar msg
    puts "#{msg} : #{@blech}"
  end
end

str = ''
m.generate  str
puts str

#eval str
