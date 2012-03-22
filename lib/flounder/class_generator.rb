module Flounder

  class ClassGenerator

    attr_accessor :name, :parent, :mixin, :namespace, :properties

    def initialize
      self.name = ''
      self.namespace = ''
      self.parent = nil
      self.mixin = nil
      self.properties = nil
      yield self if block_given?
    end

    def symbolize name
      unless name == nil or name == ''
        first = name.slice(0).capitalize
        rest = name.slice 1, name.size
        @name = first + rest
      else
        @name = name
      end
      unless @name == nil
        puts @name
        new_name = @name.gsub! /#|\/|:|\./, '_'
        puts new_name
        @name == new_name unless new_name == nil || new_name == ''
        puts @name
      end
      @name
    end

    def generate str = '', indent = 0

      indent.times { str << "\t" } ; str << "class #{symbolize name}"
      str << " < #{symbolize parent.name}" if parent

      indent.times { str << "\t" } ; str << "\n"
      indent.times { str << "\t" } ; str << "\tinclude #{mixin.name}" if mixin
      # str << "\n"

      unless properties == nil

        orderings = generate_orderings

        if mixin
          str << ", Comparable\n"
        else
          indent.times { str << "\t" } ; str << "include Comparable\n" 
        end


        ordering = orderings[name]
        arr = ordering.to_s.gsub! /"/, ''

        indent.times { str << "\t" } ;str << "\tdef <=> obj\n"
        indent.times { str << "\t" } ;str << "\t\tordering = #{arr}\n"
        indent.times { str << "\t" } ;str << "\t\tc_idx = ordering.index self.class\n"
        indent.times { str << "\t" } ;str << "\t\to_idx = ordering.index obj.class\n"
        indent.times { str << "\t" } ;str << "\t\treturn nil if c_idx == nil || o_idx == nil\n"
        indent.times { str << "\t" } ;str << "\t\tc_idx < o_idx ? -1 : 1\n"
        indent.times { str << "\t" } ;str << "\tend\n"
      else
        str << "\n"
      end

      indent.times { str << "\t" } ; str << "end\n"
      str
    end

    def generate_orderings
      orderings = {}
      properties.each do |p|
        property_name = p[:property]
        object_name = p[:object]

        active_ordering = orderings[name] || orderings[object_name] || []

        has_clazz = active_ordering.include? name
        has_object = active_ordering.include? object_name

        if property_name == 'isLowerThan'

          if !has_clazz && !has_object
            active_ordering.push name
            active_ordering.push object_name
          elsif has_clazz && !has_object
            clazz_idx = active_ordering.index name
            active_ordering.insert clazz_idx + 1, object_name
          elsif !has_clazz && has_object
            object_idx = active_ordering.index object_name
            active_ordering.insert object_idx, name
          end 

        elsif property_name == 'isGreaterThan'

          if !has_clazz && !has_object
            active_ordering.push object_name
            active_ordering.push name
          elsif has_clazz && !has_object
            clazz_idx = active_ordering.index name
            active_ordering.insert clazz_idx, object_name
          elsif !has_clazz && has_object
            object_idx = active_ordering.index object_name
            active_ordering.insert object_idx + 1, name
          end 

        end

        orderings[name] = active_ordering if orderings[name] == nil
        orderings[object_name] =  active_ordering if orderings[object_name] == nil
      end
      orderings
    end

  end

end