require 'json'

class Store
    def initialize
      data = File.read('./products.json')
      @products_data= JSON.parse(data)
    end

    def variants(product)
      hash_variants = show_variants(product)
      build_response_variants(hash_variants)
    end

    def tree(product,option=nil)
      hash_variants = show_variants(product)
      hash_variants
      build_tree(hash_variants, option)
    end

    private

    def build_tree(hash_variants, option=nil)
      option = hash_variants.keys[0] if option.nil?
      values = hash_variants[option]
      hash_variants.delete(option)
      unless values.nil?
        hash_general = {
          opcion: option,
          valores: build_branch(values, hash_variants)
        }
      end
    end
    def build_branch(values, hash_variants)
      hash = {}
      values.each do |value|
        hash[value] = build_tree(hash_variants)
      end
      puts "xxxxxxxxxxxxxxxxxxxxxxx"
      pp hash
    end
    def show_variants(product)
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
      hash_variants
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

