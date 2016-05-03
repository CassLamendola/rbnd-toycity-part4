class Module
  	def create_finder_methods(*attributes)
    	attributes.each do |attribute|
    		new_method = %Q{
    			def self.find_by_#{attribute}(val)
    				self.all.each do |product|
    					if product.#{attribute} == val
    						return product
    					end
    				end
    			end
    		}
    		class_eval(new_method)
    	end
    end
end
