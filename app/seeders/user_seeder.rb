class UserSeeder
  USERS = [
    {
      username: "member",
      email: "member@member.com",
      password: "password",
      first_name: "Member",
      last_name: "User",
      role: "member"
    }, {
      username: "admin",
      email: "admin@admin.com",
      password: "password",
      first_name: "Admin",
      last_name: "User",
      role: "admin"
    }
  ]

  def self.seed!
    USERS.each do |user|
      User.find_or_create_by!(user)
    end
  end
end
