class User < ApplicationRecord
  has_many :reservations
  has_many :rooms, through: :reservations
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #追加バリデーション
  validates :username, presence: true
  validates :bio, length: { maximum: 100 }
end
