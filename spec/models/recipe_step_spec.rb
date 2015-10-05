require 'rails_helper'

RSpec.describe RecipeStep, type: :model do
  it { should belong_to :recipe }
  it { should have_many :ingredient_lists}

  it { should have_valid(:body).when("tomatoes", "soy sauce") }
  it { should_not have_valid(:body).when(nil, '') }

  it { should have_valid(:order).when("1", "5") }
  it { should_not have_valid(:order).when(nil, '', '5.5', 'hello', '0', '-5') }
end
