class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_steps
  has_many :ingredient_lists
  has_many :ingredients, through: :ingredient_lists
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories

  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :recipe_steps
  accepts_nested_attributes_for :ingredient_lists

  validates :user_id, presence: true
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :cooking_time, numericality: {
    only_integer: true,
    greater_than: 0,
    allow_nil: true }
  validates :num_served_min, numericality: {
    only_integer: true,
    greater_than: 0,
    allow_nil: true }
  validates :num_served_max, numericality: {
    only_integer: true,
    greater_than: 0,
    allow_nil: true }
  validates :complexity, numericality: { allow_nil: true, only_integer: true }
  validates :complexity, inclusion: { in: [nil, 1, 2, 3] }

  def complexity_rating
    (complexity.present?) ? "Complexity: #{complexity}" : ""
  end

  def cooking_time_min
    (cooking_time.present?) ? "Cooking time: #{cooking_time} minutes" : ""
  end

  def num_served
    if num_served_min.present? && num_served_min <= num_served_max
      "Serves #{num_served_min}-#{num_served_max}"
    else
      ""
    end
  end
end
