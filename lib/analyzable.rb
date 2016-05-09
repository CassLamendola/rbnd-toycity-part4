module Analyzable
  	def average_price(product_arr)
  		total_price = 0
  		product_arr.each do |product|
  			total_price += product.price
  		end
  		(total_price / product_arr.length).round(2)
  	end

  	def count_by_brand(product_arr)
  		product_arr.each_with_object(Hash.new(0)) do |product, total|
  			total[product.brand] += 1
  		end
  	end

  	def count_by_name(product_arr)
  		product_arr.each_with_object(Hash.new(0)) do |product, total|
  			total[product.name] += 1
  		end
  	end


  	def print_report(product_arr)
  		report = "Inventory by Brand: \n"
  		count_by_brand(product_arr).each do |brand, total|
  			report << " - #{brand}: #{total}\n"
  		end
  		report << "Inventory by Name:\n"
  		count_by_name(product_arr).each do |name, total|
  			report << " - #{name}: #{total}\n"
  		end
  		return report
  	end

end
