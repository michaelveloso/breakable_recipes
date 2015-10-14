require 'rails_helper'

RSpec.describe RecipeCart, type: :model do
  it { should belong_to :user }
  it { should have_many :carted_recipes }
  it { should have_many :recipes }

  it 'should default to ordered false' do
    user = FactoryGirl.create(:user)
    cart = RecipeCart.create(user: user)
    expect(cart.ordered).to eq(false)
  end
end
