require_relative '../lib/flounder/parser'

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

elements = r[:elements]


clazzez = []
comp_str = "def comparator lhs, rhs\n\t"
comp_str << 'puts "lhs: #{lhs} rhs: #{rhs}\n"'
comp_str << "\n"
elements.each do |e|
  clazz_name = get_class_name e
  clazzez.push clazz_name

  e[1][:properties].each do |p|

    object_name = p[:object]

    if p[:property] == 'isGreaterThan'
      comp_str << "\treturn 1 if lhs == '#{clazz_name}' && rhs == '#{object_name}'\n"
      comp_str << "\treturn -1 if lhs == '#{object_name} && rhs == #{clazz_name}'\n" 
    elsif p[:property] == 'isLowerThan'
      comp_str << "\treturn -1 if lhs == '#{clazz_name}' && rhs == '#{object_name}'\n"
      comp_str << "\treturn 1 if lhs == '#{object_name}' && rhs == '#{clazz_name}'\n"
    end
    
  end

end

comp_str << "\treturn -1\n"
comp_str << "end\n"
comp_str << "comparator x, y\n"

puts comp_str

puts clazzez.to_s

# x, y = 'Context', 'Device'
# eval comp_str
puts "\n\n=== Sorting... ===\n\n"
new_clazzez = clazzez.sort! { |x,y| eval comp_str }

puts new_clazzez.to_s

# str = comp_str
# elements.each do |e|
#   clazz_name = get_class_name e
#   str << "class #{clazz_name}\n"
# unless e[1][:properties].size == 0
#   str << "\tinclude Comparable\n\tdef <=> obj\n" 
#   str << "\t\tcomparator self, obj\n"
#   str << "\tend\n"
# end
#   str << "end\n\n" 
# end

# puts str

# eval str

# ts = Top_Secret.new
# s = Secret.new
# u = Unclassified.new

# puts u < s
# puts s < u
# puts ts < u