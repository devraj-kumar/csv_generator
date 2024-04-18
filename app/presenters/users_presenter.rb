class UsersPresenter
  def initialize(users)
    @users = users
  end

  def present
    @users.map do |user|
      {
        id: user.id,
        username: user.username,
        email: user.email
      }
    end
  end
end
