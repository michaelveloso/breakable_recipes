class Ingredient < ActiveRecord::Base
  has_many :ingredient_lists
  has_many :recipes, through: :ingredient_lists

  validates :name, presence: true
  validates :name, uniqueness: { scope: :subtype }

  def to_s
    string = "#{name}"
    string = "#{subtype} " + string if subtype.present?
    string
  end

  def for_dropdown
    string = "#{name}"
    string += ", #{subtype}" if subtype.present?
    string
  end

  def self.options_for_select
    options = [['(Choose an ingredient)', nil]]
    self.order(:name, :subtype).each do |ingredient|
      options << [ingredient.for_dropdown, ingredient.id]
    end
    options
  end
end
