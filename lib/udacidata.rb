require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
	
	@@data_path = File.dirname(__FILE__) + "/../data/data.csv"
	create_finder_methods("brand", "name")

	def self.create(attributes = {})
		new_product = new(attributes)
		database_length = CSV.read(@@data_path).length
		if new_product.id <= database_length
			new_product.add_to_database
      	end
      	return new_product
    end


    def self.all
    	@database = []
    	CSV.foreach(@@data_path, {headers: true}) do |row|
    		@database << new(id: row[0], brand: row[1], name: row[2], price: row[3].to_f)
    	end
    	return @database
    end

    def self.first(num = nil)
    	num ? all[0..(num-1)] : all.first
    end

    def self.last(num = nil)
    	num ? all.pop(num) : all.pop
    end

    def self.find(id)
    	all.each do |product|
    		return product if product.id == id
    	end
    end

    def self.destroy(id)
    	product = find(id)
    	all.delete(product)
    	product.remove_from_database
    end

    def self.where(options = {})
    	if options[:brand]
    		all.select do |product|
    			product.brand == options[:brand]
    		end
    	else
    		all.select do |product|
    			product.name == options[:name]
    		end
    	end
    end

    def update(options = {})
    	self.brand = options[:brand] if options[:brand]
    	self.price = options[:price] if options[:price]
    	self.name = options[:name] if options[:name]
    	self.remove_from_database
    	self.add_to_database
    	return self
    end


    def add_to_database
    	data = [self.id.to_s,self.brand,self.name,self.price]
    	CSV.open(@@data_path, "a") do |csv|
    		csv << data
    	end
    end

    def remove_from_database
		table = CSV.table(@@data_path, {headers:true})
		table.delete_if do |row|
			row[:id] == self.id
	   	end
	   	File.open(@@data_path, "wb") do |csv|
	   		csv.write(table.to_csv)
	   	end
	   	return self
    end

end
