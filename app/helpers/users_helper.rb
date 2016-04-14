module UsersHelper
  def user_by_id(id)
    User.find_by_id(id)
  end
end
