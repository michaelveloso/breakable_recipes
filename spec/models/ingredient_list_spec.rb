require 'rails_helper'

RSpec.describe IngredientList, type: :model do

  it { should belong_to :ingredient }
  it { should belong_to :recipe }
  it { should belong_to :recipe_step }

  it { should have_valid(:amount).when("2 tablespoons", "4 cups") }
end
