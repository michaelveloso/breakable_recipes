class UserSeeder
  USERS = [
    {
      username: "mjveloso",
      email: ENV['GMAIL_ADDRESS'],
      password: ENV['RECIPE_COLLECTOR_PASSWORD'],
      password_confirmation: ENV['RECIPE_COLLECTOR_PASSWORD'],
      first_name: "Michael",
      last_name: "Veloso",
      role: "admin"
    }
  ]

  def self.seed!
    USERS.each do |user|
      User.create(user)
    end
  end
end
