require 'json'

class Store
    def initialize
      data = File.read('./products.json')
      @products= JSON.parse(data)
    end

    def variants(product_variant)
      arr_color = ["color"]
      arr_size = ["talla"]
      arr_material = ["material"]

      @products.each do |product|
         if product["producto"] == product_variant
           filter_products(product, arr_color, arr_size, arr_material)
         end
      end

      arr = [arr_color, arr_size, arr_material]
      build_response_variants(arr)
    end

    private

    def build_response_variants(arr)
      response = []
      arr.each do |element|
        next if element.count == 1
        response.push({
          opcion: element[0],
          valores: element[1, element.count-1]
        })
      end
      pp response
      response
    end

    def filter_products(product, arr_color, arr_size, arr_material)
      color = product["color"]
      size = product["talla"]
      material = product["material"]

      arr_color.push(color) unless (arr_color.include? color or color.nil?)
      arr_size.push(size) unless (arr_size.include? size or size.nil?)
      arr_material.push(material) unless (arr_material.include? material or material.nil?)
    end
end
store = Store.new
store.variants("gorro")