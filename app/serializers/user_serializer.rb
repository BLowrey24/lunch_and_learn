class UserSerializer
  include JSONAPI::Serializer

  def initialize(user)
    @user = user
  end

  def serialize
    {
      data: {
        type: 'user',
        id: @user.id,
        attributes: {
          name: @user.name,
          email: @user.email,
          api_key: @user.api_key
        }
      }
    }
  end
end
