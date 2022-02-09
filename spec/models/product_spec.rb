require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(name: 'Sports')
      @product = Product.new(name: 'Basketball', category: @category, price_cents: 40, quantity: 8)
    end

    it 'create a product' do
      expect(@product).to be_valid
    end
    it 'error when product has no category' do
      @product.category = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
    it 'error when a product has no price' do
      @product.price_cents = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Price cents can't be blank")
    end
    it 'error when product has no quantity' do
      @product.quantity = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'gives error when no name is inserted' do
      @product.name = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
  end
end 