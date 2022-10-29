require 'json'
require 'rspec/autorun'
require './store.rb'

data = File.read('./products.json')
products= JSON.parse(data)

describe Store do
  let(:store) { Store.new }

  products.each do |product|
    if product["producto"] == "polera"
        it "variants products polera" do
            response = [{:opcion=>"color", :valores=>["roja", "verde", "azul"]},
                        {:opcion=>"talla", :valores=>["S", "M", "L"]},
                        {:opcion=>"material", :valores=>["algodon", "poliester"]}]

            expect(store.variants(product["producto"])).to eq(response)
        end
    elsif product["producto"] == "calcetines"
        it "variants products calcetines" do
            response = [{:opcion=>"color", :valores=>["blanco", "negro"]},
                        {:opcion=>"talla", :valores=>["chico", "grande"]}]

            expect(store.variants(product["producto"])).to eq(response)
        end
    elsif product["producto"] == "gorro"
        it "variants products gorro" do
            response = [{:opcion=>"color", :valores=>["cafe", "negro"]}]

            expect(store.variants(product["producto"])).to eq(response)
        end
    end
  end
end