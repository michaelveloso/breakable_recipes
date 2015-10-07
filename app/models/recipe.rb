class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_steps
  has_many :ingredient_lists
  has_many :ingredients, through: :ingredient_lists
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories

  accepts_nested_attributes_for :categories

  validates :user_id, presence: true
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :cooking_time, numericality: {
    only_integer: true, greater_than_or_equal_to: 0 }
  validates :num_served_min, numericality: {
    only_integer: true, greater_than_or_equal_to: 0 }
  validates :num_served_max, numericality: {
    only_integer: true, greater_than_or_equal_to: 0 }
  validates :complexity, numericality: {
    only_integer: true }
  validates :complexity, inclusion: { in: (0..3) }

  def complexity_rating
    (complexity == 0) ? "" : complexity
  end

  def cooking_time_min
    (cooking_time == 0) ? "" : "Cooking time: #{cooking_time} minutes"
  end

  def num_served
    if num_served_min > 0 && num_served_min <= num_served_max
      "Serves #{num_served_min}-#{num_served_max}"
    else
      ""
    end
  end
end
