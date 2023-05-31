module UsersHelper
  def avatars_attached?(user)
    if user.avatars.attached?
      return user.avatars[0]
    else
      return app/assets/images/default_avatar.png
    end
  end
end
