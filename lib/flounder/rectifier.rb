require_relative 'class_generator'
require_relative 'module_generator'

require 'set'

module Flounder

  class Rectifier

    def rectify elements, structure
      module_names = Set.new
      module_elements = {}
      elements.keys.each do |k|
        module_elements[k] = create_class_generator k, \
          module_names, \
          elements[k][:properties]
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


      module_members = {:base => []}
      module_names.each do |module_name|
        module_members[module_name] = []
      end

      new_elements.each do |e|
        key = e.namespace == '' ? :base : e.namespace
        module_members[key].push e
      end

      module_generators = []
      module_members.each do |k,v|
        next if k == :base
        module_generators.push create_module_generator k, v
      end

      str = ''
      module_members[:base].each do |c|
        c.generate str
      end

      module_generators.each do |m|
        m.generate str
      end

      str.gsub! /#|\/|:|\./, '_'
      puts str
      str
    end

    private

    def create_module_generator name, elements
      ModuleGenerator.new do |ctx|
        ctx.elements = elements
        ctx.name = name
      end
    end

    def create_class_generator name, module_names, properties = nil
      class_name = name.to_s.split '#'
      module_names.add class_name[0] if class_name.size > 1

      clazz = ClassGenerator.new do |ctx|
        ctx.name = class_name.last
        ctx.properties = properties
        ctx.namespace = class_name[0] if class_name.size > 1
      end
      clazz
    end

    def find_parent clazz, catalog, structure
      return [] if clazz == nil
      #puts clazz.name
      qualified_name = clazz.namespace == '' \
        ? clazz.name \
        : clazz.namespace + '#' + clazz.name
      parent_name = structure[qualified_name]
      #puts "pname : #{parent_name}"
      return [] if parent_name == nil
      parent = catalog[parent_name]
      clazz.parent = parent
      return [parent] + find_parent(parent, catalog, structure)
    end

  end

end