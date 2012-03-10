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

class ModuleGenerator

  attr_accessor :name, :elements

  def initialize
    yield self if block_given?
  end

  def generate
    print "module #{name}\n\n"
    elements.each { |e| e.generate }
    print "\n\nend\n\n"
  end

end

class ClassGenerator

  attr_accessor :name, :parent

  def initialize
    yield self if block_given?
  end

  def generate
    print "class #{name}"
    print " < #{parent}" if parent
    print "\n"
    print "\n\nend"
  end

end

g = ClassGenerator.new do |ctx|
  ctx.name = 'Name'
  ctx.parent = 'Parent'
end

m = ModuleGenerator.new do |ctx|
  ctx.name = 'ModuleName'
  ctx.elements = [g]
end

m.generate
