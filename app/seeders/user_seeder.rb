class UserSeeder
  USERS = [
    {
      username: "mjveloso",
      email: "mjv.audio@gmail.com",
      password: "password",
      password_confirmation: "password",
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
