require_relative 'class_generator'
require_relative 'module_generator'

require 'set'

module Flounder

  class Rectifier

    def rectify elements, structure
      module_names = Set.new
      module_elements = {}
      elements.each do |k, v|

        class_name = k.to_s.split '#'
        #puts "raw => #{k.to_s}"
        #puts "split => #{class_name}"
        module_names.add class_name[0] if class_name.size > 1

        clazz = ClassGenerator.new do |ctx|
          ctx.name = class_name.last # k.to_s
          ctx.namespace = class_name[0] if class_name.size > 1
        end
        module_elements[k.to_sym] = clazz
      end

      # module_names.each { |e| puts e }

      new_elements = []
      structure.each do |k,v|
        clazz = module_elements[k]
        #puts clazz.namespace + '#' + clazz.name
        elems = find_parent clazz, module_elements, structure
        elems = [clazz] + elems
        elems.reverse.each do |x|
          new_elements.push x unless new_elements.include? x
        end
      end


      modules = {:base => []}
      module_names.each do |module_name|
        modules[module_name] = []
      end

      new_elements.each do |e|
        key = e.namespace == '' ? :base : e.namespace
        modules[key].push e
      end

      mods = []
      modules.each do |k,v|
        next if k == :base
        m = ModuleGenerator.new do |ctx|
          ctx.elements = v
          ctx.name = k
        end
        mods.push m
      end

      str = ''
      modules[:base].each do |c|
        c.generate str
      end

      mods.each do |m|
        m.generate str
      end

      str.gsub! /#|\/|:|\./, '_'
      str
    end

    private

    def find_parent clazz, catalog, structure
      return [] if clazz == nil
      #puts clazz.name
      qualified_name = clazz.namespace == '' \
        ? clazz.name \
        : clazz.namespace + '#' + clazz.name
      parent_name = structure[qualified_name.to_sym]
      #puts "pname : #{parent_name}"
      return [] if parent_name == nil
      parent = catalog[parent_name]
      clazz.parent = parent
      return [parent] + find_parent(parent, catalog, structure)
    end

  end

end