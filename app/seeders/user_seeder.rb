class UserSeeder
  USERS = [
    {
      username: "member",
      email: "member@member.com",
      password: "password",
      password_confirmation: "password",
      first_name: "Member",
      last_name: "User",
      role: "member"
    }, {
      username: "mod",
      email: "mod@mod.com",
      password: "password",
      password_confirmation: "password",
      first_name: "Moderator",
      last_name: "User",
      role: "moderator"
    },{
      username: "admin",
      email: "admin@admin.com",
      password: "password",
      password_confirmation: "password",
      first_name: "Admin",
      last_name: "User",
      role: "admin"
    }
  ]

  def self.seed!
    USERS.each do |user|
      User.create!(user)
    end
  end
end
