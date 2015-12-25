require 'rails_helper'

RSpec.describe Category, type: :model do

  it { should have_valid(:name).when("Asian", "Pork") }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_many :recipe_categories }
  it { should have_many :recipes }

  it 'should not validate duplicate names' do
    Category.create(name: "Italian")
    category_invalid = Category.new(name: "Italian")
    expect(category_invalid.valid?).to eq(false)
  end

  it 'should offer all categories as options' do
    Category.create(name: "French")
    Category.create(name: "Asian")
    category_options = Category.options_for_select
    french_id = Category.where(name: "French")[0].id
    asian_id = Category.where(name: "Asian")[0].id
    expect(category_options).to be_a(Array)
    expect(category_options[0]).to eq(["(Choose a category)", nil])
    expect(category_options.include?(["French", french_id])).to eq(true)
    expect(category_options.include?(["Asian", asian_id])).to eq(true)
  end
end
