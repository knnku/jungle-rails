require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do

    before do

      fake_category = Category.new
      product_one = Product.new(:name => nil, :price => 20, :quantity => 5, :category => fake_category)

    end

    describe "validates: name" do
      it "validates presence of :name by returning false if empty" do
        expect(product_one).to include 
      end
    end

  end
end
