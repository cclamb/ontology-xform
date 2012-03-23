require_relative '../lib/flounder/parser'
require_relative '../lib/flounder/rectifier'

include Flounder

#filename = 'Ontology2.owl'
filename = 'Ontology.owl'
#filename = 'simple-ontology.owl'

# p = Parser.new
# xml = File.read filename
# r = p.parse xml
# rectifier = Rectifier.new
# od = rectifier.rectify r[:elements], r[:structure]
# puts od

class Foo
  attr_accessor :name

  def initialize name
    self.name = name
  end

  def == obj 
    self.class == obj.class && self.name == obj.name
  end

  def eql? obj
    self == obj
  end

  def hash
    self.name.hash
  end
end

f = Foo.new 'a'
b = Foo.new 'a'
nf = Foo.new 'b'

puts f == b
puts f != b
puts b != f
puts nf == f
puts f != nf

puts f.hash
puts b.hash
puts nf.hash

puts f.eql? b

x = Foo.new 'a'
case x
when f
  puts 'f'
when b
  puts 'b'
end