require_relative 'class_generator'
require_relative 'module_generator'
require_relative 'comparator_generator'
require_relative 'equality_generator'

require 'set'

module Flounder

  class Rectifier

    def rectify elements, structure

      orderings = {}
      elements.each do |e|
        clazz_name = e[0].split('#').last

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

      module_names = Set.new
      module_elements = {}
      elements.keys.each do |k|

        ordering = orderings[k.split('#').last]

        methods = []
        std_mixin_name = nil
        if ordering != nil 
          methods.push Flounder::ComparatorGenerator.new ordering
          std_mixin_name = 'Comparable'
        else
          methods.push Flounder::EqualityGenerator.new
        end

        module_elements[k] = create_class_generator k, \
          module_names, \
          methods, \
          std_mixin_name
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

      str
    end

    private

    def create_module_generator name, elements
      ModuleGenerator.new do |ctx|
        ctx.elements = elements
        ctx.name = name
      end
    end

    def create_class_generator name, module_names, methods = [], mixin = nil
      class_name = name.to_s.split '#'
      module_names.add class_name[0] if class_name.size > 1

      clazz = ClassGenerator.new do |ctx|
        ctx.name = class_name.last
        ctx.namespace = class_name[0] if class_name.size > 1
        ctx.methods = methods
        ctx.mixin = mixin unless mixin == nil
      end
      clazz
    end

    def find_parent clazz, catalog, structure
      return [] if clazz == nil

      qualified_name = clazz.namespace == '' \
        ? clazz.name \
        : clazz.namespace + '#' + clazz.name

      parent_name = structure[qualified_name]

      return [] if parent_name == nil

      parent = catalog[parent_name]

      clazz.parent = parent

      return [parent] + find_parent(parent, catalog, structure)
    end

  end

end