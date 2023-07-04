module UsersHelper
  def avatars_attached?(user)
    if user.avatars.attached?
      return user.avatars[0]
    else
      return image_path('default-avatar.jpeg')
    end
  end
end
