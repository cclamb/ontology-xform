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

  def generate
    print "module #{name}\n\n"
    elements.each { |e| e.generate }
    print "end\n\n"
  end

end

class MethodGenerator

  attr_accessor :name, :instructions

  def initialize
    name = ''
    instructions = []
    yield self if block_given?
  end

  def generate
    print "def #{name}\n"
    instructions.each { |i| print "\t#{i}\n"}
    print "end\n\n"
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

  def generate
    print "class #{name}"
    print " < #{parent}" if parent
    print "\n"
    print "\tinclude #{included_module.name}" if included_module
    print "\n\nend\n\n"
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

m.generate
