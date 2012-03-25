module Http___www_semanticweb_org_ontologies_2012_1_Ontology_owl
	class Context	
			attr_accessor :value
			def == obj
				self.class == obj.class && self.value == obj.value
			end
			def eql? obj
				self == obj
			end
			def hash
				self.value.hash
			end
	end
	class Environment < Context	
			attr_accessor :value
			def == obj
				self.class == obj.class && self.value == obj.value
			end
			def eql? obj
				self == obj
			end
			def hash
				self.value.hash
			end
	end
	class Device < Environment	
			attr_accessor :value
			def == obj
				self.class == obj.class && self.value == obj.value
			end
			def eql? obj
				self == obj
			end
			def hash
				self.value.hash
			end
	end
	class Domain	
			attr_accessor :value
			def == obj
				self.class == obj.class && self.value == obj.value
			end
			def eql? obj
				self == obj
			end
			def hash
				self.value.hash
			end
	end
	class SecurityDomain < Domain	
			attr_accessor :value
			def == obj
				self.class == obj.class && self.value == obj.value
			end
			def eql? obj
				self == obj
			end
			def hash
				self.value.hash
			end
	end
	class JWICS < SecurityDomain	
		include Comparable
		def <=> obj
			ordering = ["NIPRNet", "SIPRNet", "JWICS", "NASNet"]
			obj_short_name = obj.class.to_s.split('::').last
			self_short_name = self.class.to_s.split('::').last
			c_idx = ordering.index self_short_name
			o_idx = ordering.index obj_short_name
			return nil if c_idx == nil || o_idx == nil
			if c_idx < o_idx
				return -1
			elsif c_idx > o_idx
				return 1
			else
				return 0
			end
		end
	end
	class NASNet < SecurityDomain	
		include Comparable
		def <=> obj
			ordering = ["NIPRNet", "SIPRNet", "JWICS", "NASNet"]
			obj_short_name = obj.class.to_s.split('::').last
			self_short_name = self.class.to_s.split('::').last
			c_idx = ordering.index self_short_name
			o_idx = ordering.index obj_short_name
			return nil if c_idx == nil || o_idx == nil
			if c_idx < o_idx
				return -1
			elsif c_idx > o_idx
				return 1
			else
				return 0
			end
		end
	end
	class NIPRNet < SecurityDomain	
		include Comparable
		def <=> obj
			ordering = ["NIPRNet", "SIPRNet", "JWICS", "NASNet"]
			obj_short_name = obj.class.to_s.split('::').last
			self_short_name = self.class.to_s.split('::').last
			c_idx = ordering.index self_short_name
			o_idx = ordering.index obj_short_name
			return nil if c_idx == nil || o_idx == nil
			if c_idx < o_idx
				return -1
			elsif c_idx > o_idx
				return 1
			else
				return 0
			end
		end
	end
	class OS < Environment	
			attr_accessor :value
			def == obj
				self.class == obj.class && self.value == obj.value
			end
			def eql? obj
				self == obj
			end
			def hash
				self.value.hash
			end
	end
	class Subject < Context	
			attr_accessor :value
			def == obj
				self.class == obj.class && self.value == obj.value
			end
			def eql? obj
				self == obj
			end
			def hash
				self.value.hash
			end
	end
	class Project < Subject	
			attr_accessor :value
			def == obj
				self.class == obj.class && self.value == obj.value
			end
			def eql? obj
				self == obj
			end
			def hash
				self.value.hash
			end
	end
	class Role < Subject	
			attr_accessor :value
			def == obj
				self.class == obj.class && self.value == obj.value
			end
			def eql? obj
				self == obj
			end
			def hash
				self.value.hash
			end
	end
	class SIPRNet < SecurityDomain	
		include Comparable
		def <=> obj
			ordering = ["NIPRNet", "SIPRNet", "JWICS", "NASNet"]
			obj_short_name = obj.class.to_s.split('::').last
			self_short_name = self.class.to_s.split('::').last
			c_idx = ordering.index self_short_name
			o_idx = ordering.index obj_short_name
			return nil if c_idx == nil || o_idx == nil
			if c_idx < o_idx
				return -1
			elsif c_idx > o_idx
				return 1
			else
				return 0
			end
		end
	end
	class SecurityClassification < Domain	
			attr_accessor :value
			def == obj
				self.class == obj.class && self.value == obj.value
			end
			def eql? obj
				self == obj
			end
			def hash
				self.value.hash
			end
	end
	class Secret < SecurityClassification	
		include Comparable
		def <=> obj
			ordering = ["Unclassified", "Secret", "Top_Secret"]
			obj_short_name = obj.class.to_s.split('::').last
			self_short_name = self.class.to_s.split('::').last
			c_idx = ordering.index self_short_name
			o_idx = ordering.index obj_short_name
			return nil if c_idx == nil || o_idx == nil
			if c_idx < o_idx
				return -1
			elsif c_idx > o_idx
				return 1
			else
				return 0
			end
		end
	end
	class Top_Secret < SecurityClassification	
		include Comparable
		def <=> obj
			ordering = ["Unclassified", "Secret", "Top_Secret"]
			obj_short_name = obj.class.to_s.split('::').last
			self_short_name = self.class.to_s.split('::').last
			c_idx = ordering.index self_short_name
			o_idx = ordering.index obj_short_name
			return nil if c_idx == nil || o_idx == nil
			if c_idx < o_idx
				return -1
			elsif c_idx > o_idx
				return 1
			else
				return 0
			end
		end
	end
	class Unclassified < SecurityClassification	
		include Comparable
		def <=> obj
			ordering = ["Unclassified", "Secret", "Top_Secret"]
			obj_short_name = obj.class.to_s.split('::').last
			self_short_name = self.class.to_s.split('::').last
			c_idx = ordering.index self_short_name
			o_idx = ordering.index obj_short_name
			return nil if c_idx == nil || o_idx == nil
			if c_idx < o_idx
				return -1
			elsif c_idx > o_idx
				return 1
			else
				return 0
			end
		end
	end
end
