class User < ActiveRecord::Base
  has_many :recipes, dependent: :destroy
  has_many :recipe_carts, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribed_recipes, through: :subscriptions, source: :recipe

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true
  validates :role, inclusion: { in: %w(member moderator admin) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def moderator?
    role == 'admin' || role == 'moderator'
  end

  def admin?
    role == 'admin'
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def cart
    if last_recipe_cart && last_recipe_cart.ordered == false
      last_recipe_cart
    else
      RecipeCart.create(user_id: id)
    end
  end

  def last_recipe_cart
    RecipeCart.where(user_id: id).order(created_at: :desc).limit(1)[0]
  end

  def current_role_string
    if admin?
      "#{username} is now an admin"
    else
      "#{username} is now a #{role}"
    end
  end
end
