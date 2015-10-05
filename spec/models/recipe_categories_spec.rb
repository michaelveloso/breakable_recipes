require 'rails_helper'

RSpec.describe RecipeCategory, type: :model do

  it { should belong_to :category }

end
