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

orderings = {}
elements.each do |e|
  clazz_name = get_class_name e

  e[1][:properties].each do |p|
    property_name = p[:property]
    object_name = p[:object]

    active_ordering = orderings[clazz_name] || orderings[object_name] || []

    has_clazz = active_ordering.include? clazz_name
    has_object = active_ordering.include? object_name

    if property_name == 'isLowerThan'

      if !has_clazz && !has_object
        active_ordering.push clazz_name
        active_ordering.push object_name
      elsif has_clazz && !has_object
        clazz_idx = active_ordering.index clazz_name
        active_ordering.insert clazz_idx + 1, object_name
      elsif !has_clazz && has_object
        object_idx = active_ordering.index object_name
        active_ordering.insert object_idx, clazz_name
      end 

    elsif property_name == 'isGreaterThan'

      if !has_clazz && !has_object
        active_ordering.push object_name
        active_ordering.push clazz_name
      elsif has_clazz && !has_object
        clazz_idx = active_ordering.index clazz_name
        active_ordering.insert clazz_idx, object_name
      elsif !has_clazz && has_object
        object_idx = active_ordering.index object_name
        active_ordering.insert object_idx + 1, clazz_name
      end 

    end

    orderings[clazz_name] = active_ordering if orderings[clazz_name] == nil
    orderings[object_name] =  active_ordering if orderings[object_name] == nil
  end

end

m_str = ''
orderings.each do |k,v| 
  arr = v.to_s.gsub! /"/, ''
  m_str << "\tdef <=> obj\n"
  m_str << "\t\tordering = #{arr}\n"
  m_str << "\t\tc_idx = ordering.index self\n"
  m_str << "\t\to_idx = ordering.index obj\n"
  m_str << "\t\treturn nil if c_idx == nil || o_idx == nil\n"
  m_str << "\t\tc_idx < o_idx ? -1 : 1\n"
  m_str << "\tend\n"
end

#puts m_str

str = ''
elements.each do |e|

  clazz_name = get_class_name e

  str << "class #{clazz_name}\n"

unless e[1][:properties].size == 0
  str << "\tinclude Comparable\n" 

  ordering = orderings[clazz_name]
  arr = ordering.to_s.gsub! /"/, ''

  str << "\tdef <=> obj\n"
  str << "\t\tordering = #{arr}\n"
  str << "\t\tc_idx = ordering.index self.class\n"
  str << "\t\to_idx = ordering.index obj.class\n"
  str << "\t\treturn nil if c_idx == nil || o_idx == nil\n"
  str << "\t\tc_idx < o_idx ? -1 : 1\n"
  str << "\tend\n"
end

  str << "end\n\n" 
end

puts str

eval str

ts = Top_Secret.new
s = Secret.new
u = Unclassified.new

puts u < s
puts s < u
puts ts < u
puts u < s
puts u < ts