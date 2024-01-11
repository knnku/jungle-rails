require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do

    describe 'creates a new category and product' do
      fake_category = Category.new
      product_test = Product.new(name: "Test", price: 20, quantity: 5, category: fake_category)
      it 'validates the successfull creation of a product and category' do
        expect(product_test.valid?).to be_truthy
      end
    end

    describe 'validates: name' do
      let(:fake_category) { Category.new }
      subject(:product_test) { Product.new(name: nil, price: 20, quantity: 5, category: fake_category) }

      it 'validates presence of :name by returning false if empty/nil' do
        expect(product_test.valid?).to be_falsey
      end
    end

    describe 'validates: price' do
      let(:fake_category) { Category.new }
      subject(:product_test) { Product.new(name: "Test", price: nil, quantity: 5, category: fake_category) }

      it 'validates presence of :price by returning 0 if set to nil' do
        expect(product_test.price).to be == 0
      end
    end

    describe 'validates: quantity' do
      let(:fake_category) { Category.new }
      subject(:product_test) { Product.new(name: "Test", price: 20, quantity: nil, category: fake_category) }

      it 'validates presence of :quantity by returning false if empty/nil' do
        expect(product_test.valid?).to be_falsey
      end
    end

    describe 'validates: category' do
      let(:fake_category) { Category.new }
      subject(:product_test) { Product.new(name: "Test", price: 20, quantity: 5, category: nil) }

      it 'validates presence of :category by returning false if empty/nil' do
        expect(product_test.valid?).to be_falsey
      end
    end

  end
end
