require 'rails_helper'

RSpec.describe Ingredient, type: :model do

  it { should have_valid(:name).when("tomatoes", "soy sauce") }
  it { should_not have_valid(:name).when(nil, '') }

end
