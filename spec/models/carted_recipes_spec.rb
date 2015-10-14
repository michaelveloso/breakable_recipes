require 'rails_helper'

RSpec.describe CartedRecipe, type: :model do
  it { should belong_to :recipe_cart }
  it { should belong_to :recipe }
end
