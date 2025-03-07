class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :room  

    #バリデーション設定
    validates :check_in_date, presence: true
    validates :check_out_date, presence: true
    validates :number_of_guests, presence: true, numericality: { greater_than: 0 }
    validate :start_end_check
    validate :start_check

    #予約総額計算
    def duration
        (check_out_date - check_in_date).to_i
    end

    def total_price
        duration * room.price * number_of_guests
    end

    #チェックアウト日バリデーション
    def start_end_check
        return if check_in_date.blank? || check_out_date.blank?
        if check_out_date < check_in_date
          errors.add(:check_out_date,"を正しく設定してください")
        end
    end
    
    #チェックイン日バリデーション
    def start_check
        return if check_in_date.blank? || check_out_date.blank?
        if Date.today > check_in_date
          errors.add(:check_in_date,"を正しく設定してください")
        end
    end
end
