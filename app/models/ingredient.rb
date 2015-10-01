class Ingredient < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { scope: :subtype }

  def description
    string = "#{name}"
    string << ", #{subtype}" if subtype.present?
    string
  end
end
