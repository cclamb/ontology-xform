require_relative '../lib/flounder/parser'

include Flounder

#filename = 'Ontology2.owl'
filename = 'Ontology2.owl'
#filename = 'simple-ontology.owl'

p = Parser.new
xml = File.read filename
r = p.parse xml

elements = r[:elements]

str = ''
elements.each do |e|
  clazz_name = e[0].split('#').last
  str << "class #{clazz_name}\n"
  str << "\tinclude Comparable\n\tdef <=> obj\n" unless e[1][:properties].size == 0
  e[1][:properties].each do |p|
    
    if p[:property] == 'isGreaterThan'
      str << "\t\treturn 1 if obj.class == #{p[:object]}\n"
    elsif p[:property] == 'isLowerThan'
      str << "\t\treturn -1 if obj.class == #{p[:object]}\n"
    end
    
  end
  str << "\tend\n" unless e[1][:properties].size == 0
  str << "end\n\n" 
end

puts str

eval str

ts = Top_Secret.new
s = Secret.new
u = Unclassified.new

puts u < s
puts s < u
puts ts <=> u