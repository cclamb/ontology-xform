require_relative 'method_generator'

module Flounder

  class ComparatorGenerator < MethodGenerator
    def initialize ordering, &block
      a = []
      a.push "ordering = #{ordering.to_s}"
      a.push "obj_short_name = obj.class.to_s.split('::').last"
      a.push "self_short_name = self.class.to_s.split('::').last"
      a.push "c_idx = ordering.index self_short_name"
      a.push "o_idx = ordering.index obj_short_name"
      a.push "return nil if c_idx == nil || o_idx == nil"
      a.push "if c_idx < o_idx"
      a.push "\treturn -1"
      a.push "elsif c_idx > o_idx"
      a.push "\treturn 1"
      a.push "else"
      a.push "\treturn 0"
      a.push "end"
      super &block
      self.name = '<=>'
      self.args = ['obj']
      self.instructions = a
    end
  end

end