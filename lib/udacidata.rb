require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
	
	@@data_path = File.dirname(__FILE__) + "/../data/data.csv"

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

    def self.all
    	database = []
    	CSV.foreach(@@data_path, {headers: true}) do |row|
    		database << new(id: row[0], brand: row[1], name: row[2], price: row[3].to_f)
    	end
    	return database
    end

    def self.first(num = nil)
    	num ? all[0..(num-1)] : all.first
    end

end
