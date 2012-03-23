module Flounder

  module Utilities

    def symbolize name
      unless name == nil or name == ''
        first = name.slice(0).capitalize
        rest = name.slice 1, name.size
        name = first + rest
      else
        name = name
      end
      unless name == nil
        new_name = name.gsub! /#|\/|:|\./, '_'
        name == new_name unless new_name == nil || new_name == ''
      end
      name
    end
    
  end

end