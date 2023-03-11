class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :profile_image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


         has_many :books, dependent: :destroy

         def profile_image
           unless image.attached?
             file_path = Rails.root.join('app/assets/images/no_image.jpg')
             image.attached(io: File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
           end
           image
         end
end
