class User < ApplicationRecord
    has_secure_password
    has_one_attached :avator

    validates :email, :username,{
        presence: true,
    }

    validates :password_reset_token,{
        uniqueness: true,
        allow_nil: true
    }
end
