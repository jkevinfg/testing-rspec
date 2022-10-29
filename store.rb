require 'json'

class Store
    def initialize
      data = File.read('./products.json')
      @products_data= JSON.parse(data)
    end

    def variants(product)
      hash_variants = {}
      @products_data.each do |product_data|
         if product_data["producto"] == product
           product_data.each do |variant,value|
             if variant != "producto" &&  variant!= "sku" && variant!= "estado"
               build_hash_variants(variant,value,hash_variants)
             end
           end
         end
      end
      build_response_variants(hash_variants)
    end

    def tree(product,option=nil)
      hash_variants = variants(product)
      option = hash_variants[0].values[0] if option.nil?
      hash_init = hash_variants.find{|arr| arr[:opcion] = option}
      hash_variants.delete(hash_init)
      values = hash_init[:valores]


    end

    private

    def recursive_tree(hash_variants, option)

    end

    def build_response_variants(hash_variants)
      response = []
      hash_variants.each{|variant, values| response.push({opcion: variant, valores: values}) }
      response
    end

    def build_hash_variants(variant,value,hash_variants)
        return hash_variants[variant] = [value] if hash_variants[variant].nil?
        hash_variants[variant].push(value) unless hash_variants[variant].include? value
    end
end
store = Store.new
store.tree("polera")

