	class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


   attachment :profile_image
   validates :name, length: { in: 2..20 }
   validates :intro, length: { maximum: 50 }

   has_many :books
   has_many :likes, dependent: :destroy
end
