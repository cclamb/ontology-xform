
module Flounder

  class Rectifier

    def rectify elements, structure
      module_elements = {}
      elements.each do |k, v|
        clazz = ClassGenerator.new do |ctx|
          ctx.name = k.to_s
          #ctx.parent = v.to_s unless v == nil
        end
        module_elements[k.to_sym] = clazz
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

      mod = ModuleGenerator.new do |ctx|
        ctx.elements = new_elements #module_elements.values
        ctx.name = 'SomeMod'
      end

      str = ''
      mod.generate str

      str.gsub! /#|\/|:|\./, '_'
    end

    private

    def find_parent clazz, catalog, structure
      return [] if clazz == nil
      #puts clazz.name
      parent_name = structure[clazz.name.to_sym]
      #puts "pname : #{parent_name}"
      return [] if parent_name == nil
      parent = catalog[parent_name]
      clazz.parent = parent
      return [parent] + find_parent(parent, catalog, structure)
    end

  end

end