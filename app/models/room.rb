class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations
  has_one_attached :image

  # 施設新規作成バリデーション
  validates :name, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { maximum: 500 }
  
  # 検索機能
  def self.search(params)
    rooms = Room.all
    
    # 地域選択
    if params[:area].present?
      rooms = rooms.where("address LIKE ?", "%#{params[:area]}%")
    end
    
    # 詳細住所検索
    if params[:address].present?
      rooms = rooms.where("address LIKE ?", "%#{params[:address]}%")
    end
    
    # キーワード検索
    if params[:keyword].present?
      keyword = params[:keyword]
      rooms = rooms.where("name LIKE ? OR description LIKE ? OR address LIKE ?",
        "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
    end
    
    return rooms
  end
end