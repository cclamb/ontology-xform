module Http___www_semanticweb_org_ontologies_2012_1_Ontology_owl
	class Device	
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
	class OS	
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
	class Project	
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
	class Role	
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
	class Security_Classificaton	
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
	class Security_Domain	
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
end
