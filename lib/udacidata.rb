require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
	
	@@data_path = File.dirname(__FILE__) + "/../data/data.csv"
	#@file = Pathname(@data_path)

	def self.create(attributes = {})
		new_product = new(attributes)
		database_length = CSV.read(@@data_path).length
		if new_product.id <= database_length
			new_product.add_to_database
      	end
      	return new_product
    end

    def add_to_database
    	data = [self.id.to_s,self.brand,self.name,self.price]
    	CSV.open(@@data_path, "a") do |csv|
    		csv << data
    	end
    end
end
