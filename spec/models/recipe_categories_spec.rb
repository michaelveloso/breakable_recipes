require 'rails_helper'

RSpec.describe RecipeCategory, type: :model do

  it { should belong_to :category }
  it { should belong_to :recipe }
end
