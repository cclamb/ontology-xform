module Http___www_semanticweb_org_ontologies_2012_1_Ontology_owl
	class Context	
	
	end
	class Environment < Context	
	
	end
	class Device < Environment	
	
	end
	class Domain	
	
	end
	class SecurityDomain < Domain	
	
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
	
	end
	class Subject < Context	
	
	end
	class Project < Subject	
	
	end
	class Role < Subject	
	
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
