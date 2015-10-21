class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_steps
  has_many :ingredient_lists
  has_many :ingredients, through: :ingredient_lists
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  has_many :carted_recipes
  has_many :recipe_carts, through: :carted_recipes

  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :recipe_steps
  accepts_nested_attributes_for :ingredient_lists

  validates :user_id, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
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
    (complexity.present?) ? "Complexity: #{complexity}" : "Complexity: ?"
  end

  def cooking_time_min
    if cooking_time.present?
      "Cooking time: #{cooking_time} minutes"
    else
      "Cooking time: ?"
    end
  end

  def num_served
    if num_served_min.present?
      if num_served_min < num_served_max
        "Serves #{num_served_min}-#{num_served_max}"
      elsif num_served_min == num_served_max
        "Serves #{num_served_min}"
      else
        "Serves #{num_served_max}-#{num_served_min}"
      end
    else
      "Serves ?-?"
    end
  end

  def toggle_string
    shared ? "Unshare" : "Share"
  end

  def share_flash_string
    shared ? "#{name} is shared!" : "#{name} is no longer shared."
  end
end
