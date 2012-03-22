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

orderings.each { |k,v| puts "#{k} => #{v}\n\n" }
