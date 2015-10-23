require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { should belong_to :recipe }
  it { should belong_to :user }
end
