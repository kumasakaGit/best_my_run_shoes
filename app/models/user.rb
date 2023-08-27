class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum gender: { man: 1, woman: 2, child: 3 }
  enum foot_width: { narrow: 1, nomal: 2, wide: 3 }

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.nick_name = "ゲスト"
      user.foot_size = 25.5
      user.foot_width = 2
      user.gender = 1
    end
  end
end
