require 'rails_helper'

RSpec.describe Category, type: :model do

  it { should have_valid(:name).when("Asian", "Pork") }
  it { should_not have_valid(:name).when(nil, '') }

  it 'should not validate duplicate names' do
    Category.create(name: "Italian")
    category_invalid = Category.new(name: "Italian")
    expect(category_invalid.valid?).to eq(false)
  end

end
