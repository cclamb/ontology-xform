#=====================================================================
#SBIR DATA RIGHTS
#Contract No. FA8750-11-C-0195
#Contractor: AHS Engineering Services (under subcontract to Modus Operandi, Inc.)
#Expiration Date: 05/03/2018                       
#Address: 5909 Canyon Creek Drive NE, Albuquerque, NM  87111
 
#The Government’s rights to use, modify, reproduce, release, perform, display, or disclose technical data or computer software marked with this legend are restricted during the period 
#shown as provided in paragraph (b) (4) of the Rights in Noncommercial Technical Data and Computer Software-Small Business Innovative Research (SBIR) Program clause contained in the 
#above identified contract. No restrictions apply after the expiration date shown above. Any reproduction of technical data, computer software, or portions thereof marked with this legend 
#must also reproduce the markings.
#=====================================================================

# Abstract class for properties.
class Prop
  def set()
  end
  
  def get()
  end
end

# ComparableProperty class derived from Prop class, defines the class of properties that are comparable, and includes the Comparable module. 
class ComparableProperty < Prop
  include Comparable
end

#SecurityClassification is a property of Resource entity.
class SecurityClassification < ComparableProperty
    attr_reader :security_classification
    attr_writer :security_classification
    
    def initialize(new_sc)
      @security_classification = new_sc
    end
  
    def to_s
      puts "Security Classification: #@security_classification"
      "Security Classification created!"
    end
  
    def <=>(new_sc)

		puts "\n\n---------------------------\nAwesome\n------------------------------\n\n"
      
      if @security_classification != "Top Secret" && @security_classification != "Secret" && @security_classification != "Confidential" && @security_classification != "Unclassified" && @security_classification != "Top Secret - SCI"
        return false
      end
        curr = @security_classification
        other = new_sc.security_classification
      if curr == "empty"
        return 0
      else
         case curr
         
		 when 'Top Secret - SCI'
			if other == 'Top Secret - SCI'
				return 0
			else
				return 1
			end


         when 'Top Secret'
            if other == 'Top Secret - SCI'
              return -1
            elsif other == 'Top Secret'
				return 0
			else
               return 1
            end
         
         when 'Secret'
            if other == 'Top Secret'
              return -1
            elsif other == 'Secret'
              return 0
            else
              return 1
            end

         when 'Confidential'
            if other == 'Unclassified'
               return 1
            elsif other == 'Confidential'
               return 0
            else return -1
            end
  
         when 'Unclassified'
            if other == 'Unclassified'
              return 0
            else 
              return -1
            end
         else
            puts "Invalid case"
         end
      end

    end
end

#Project is a property of Subject entity
class Project < ComparableProperty
    attr_reader :project_name
    attr_writer :project_name
    
    def initialize(new_p)
      @project_name = new_p
    end
  
    def to_s
      puts "Project Name: #@project_name"
    end
  
    def <=>(new_project)
      if @project_name != "Zebra" && @project_name != "Zulu" && @project_name != "Foxtrot" && @project_name != "Yankee" && @project_name != "Undefined"
        return false
      end

		if new_project.project_name == "Defined"
			if @project_name == "Undefined"
				return false
			else
				return 0
			end
		end

       if new_project.project_name == "All"
         return 0
       else
        @project_name <=> new_project.project_name
       end
    end
end

#Role is a property of Subject Entity.
class Role < ComparableProperty
    attr_reader :role
    attr_writer :role
    
    def initialize(new_role)
      @role = new_role
    end
  
    def to_s
      puts "Role: #@role"
    end
  
    def <=>(new_role)
      if @role != "Alpha" && @role != "Bravo" && @role != "Delta"
        return false
      end
       if new_role.role == "All"
         return 0
       else
         @role <=> new_role.role
       end
    end
end

#SecurityDomain is a property of Environment entity.
class SecurityDomain < ComparableProperty
    attr_reader :security_domain
    attr_writer :security_domain
    
    def initialize(new_sd)
      @security_domain = new_sd
    end
  
    def to_s
      puts "Security Domain: #@security_domain"
    end
  
    def <=>(new_sd)

      if @security_domain != "JWICS" && @security_domain != "SIPRNet" && @security_domain != "NPIRNet" && @security_domain != "OpenNet" && @security_domain != "NSANet"
        return false
      end

      if new_sd.security_domain == "All"
         return 0
       else
         curr = @security_domain
         other = new_sd.security_domain
           
           case curr
			
		   when 'NSANet'
		    if other == 'NSANet'
			  return 0
			else
			  return 1
			end			
	
           when 'JWICS'
            if other == 'NSANet'
              return -1
            elsif other == 'JWICS'
              return 0
			else
			  return 1
            end
         
         when 'SIPRNet'
            if other == 'JWICS'
              return -1
            elsif other == 'SIPRNet'
              return 0
            else
              return 1
            end

         when 'NPIRNet'
            if other == 'NPIRNet'
               return 0
            else return -1
            end
  
         else
            puts "Invalid case"
         end
          
          
          
          
          
            
           
      end
    end
    
    def among (new_sd1, new_sd2)
        if @security_domain != "JWICS" && @security_domain != "SIPRNet" && @security_domain != "NPIRNet" && @security_domain != "Public Internet"
          return false
        end
        @security_domain == new_sd1.security_domain || @security_domain == new_sd2.security_domain
    end
  
end

# OperatingSystem is a property of Environment entity.
class OperatingSystem < ComparableProperty
    attr_reader :operating_system
    attr_writer :operating_system
    
    def initialize(new_os)
      @operating_system = new_os
    end
  
    def to_s
      puts "Operating System: #@operating_system"
    end
  
    def <=>(new_os)
      if @operating_system != "SE" && @operating_system != "Version" && @operating_system != "Blackberry OS"
        return false
      end
      if new_os.operating_system == "All"
         return 0
       else
         @operating_system <=> new_os.operating_system
      end
    end
end

#Device is a property of Environment entity.
class Device < ComparableProperty
    attr_reader :device_name
    attr_writer :device_name
    
    def initialize(new_dev)
      @device_name = new_dev
    end
  
    def to_s
      puts "Device Name: #@device_name"
    end
  
    def <=>(new_dev)
       if @device_name != "Workstation" && @device_name != "Handheld" && @device_name != "Blackberry" &&  @device_name != "Terminal"
        return false
      end
      if new_dev.device_name == "All"
         return 0
      else
        @device_name <=> new_dev.device_name
      end
    end
    
    def not_eq (new_dev)
      if @device_name != "Workstation" && @device_name != "Handheld" && @device_name != "Blackberry" && @device_name != "Terminal"
        return false
      end
      ! (@device_name == new_dev.device_name)
    end
end

#Security Clearance is a property of Subject entity
class SecurityClearance < ComparableProperty
    attr_reader :security_clearance
    attr_writer :security_clearance
    
    def initialize(new_sclr)
      @security_clearance = new_sclr
    end
  
    def to_s
      puts "Security Clearance: #@security_clearance"
    end
  
    def <=>(new_sclr)
      curr = @security_clearance
      other = new_sclr.security_clearance
      
      
      case curr
	
		when 'Top Secret - SCI'
			if other == 'Top Secret - SCI'
				return 0
			elsif other == "Secret" || other == "Confidential" || other == "Top Secret"
				return 1
			end

        when "Top Secret"
			if other == "Top Secret - SCI"
				return -1
          	elsif other == "Top Secret"
            	return 0
			else
            	return 1
          	end
        
        when "Secret"
          if other == "Top Secret"
            return -1
          elsif other == "Secret" 
            return 0
          else
            return 1
          end

        when "Confidential"
          if other == "Confidential"
            return 0
          elsif other == "Secret" || other == "Top Secret" || other == "Top Secret - SCI"
            return -1
          end
      else
        puts "INVALID CASE!!!!!"
        
      end    
    end
end

# Basket is a property of DynamicEnvironment entity. 
class Basket < Prop
    attr_reader :contents
    attr_writer :contents
    
    def initialize(elements)
      @contents = elements
    end
    
  
    def to_s
    # @contents.each{|c| puts c}
    end
    
    def not_in_basket(res1)
      # res1 is of type Basket, whose contents is a single string. 
      puts "contents are :"
      @contents.each{|c| puts c}
      puts "values of res1 is:"
      puts res1.contents
      if @contents.include?(res1.contents)
        puts "res1 is in contents"
        false
      else
        puts "res1 is not in contents"
        true
        
      end
    end
  
end







#entities
class Environment < Entity
	def initialize(property_list)
		@properties = property_list
	end
end

#Subject class is derived form the Entity class. It contains subject properties.
class Subject < Entity
	def initialize(property_list)
		@properties = property_list
	end
end

#Resource Class is derived from the Entity class. It contains resource properties. 
class Resource < Entity
	def initialize(property_list)
		@properties = property_list
	end
end	

#DynamicEnvironment class is derived from the Entity class. It contains mashup environment properties. 
class DynamicEnvironment < Entity
  def initialize(property_list)
    @properties = property_list
  end
end

