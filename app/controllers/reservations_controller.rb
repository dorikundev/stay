class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show, :edit, :edit_confirmation, :update, :destroy]
  before_action :ensure_owner, only: [:show, :edit, :edit_confirmation, :update, :destroy]
  
  # 新規予約フォーム
  def new
    @reservation = Reservation.new
    @room = Room.find(params[:room_id]) if params[:room_id]
  end
  
  # 予約の詳細表示
  def show
    @room = @reservation.room
  end
  
  # 予約の編集フォーム
  def edit
    @room = @reservation.room
  end
  
  # 新規予約の確認画面
  def confirmation
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    @reservation.room = @room
    
    # バリデーション
    unless @reservation.valid?
      render 'rooms/show'
    end
  end
  
  # 編集時の確認画面
  def edit_confirmation
    @room = @reservation.room
    @reservation.assign_attributes(reservation_params)
    
    # バリデーション
    unless @reservation.valid?
      render :edit
    end
  end
  
  # 新規予約の作成
  def create
    @reservation = build_new_reservation
    
    if @reservation.save
      redirect_to own_reservations_path
    else
      @room = Room.find(params[:reservation][:room_id])
      render 'rooms/show'
    end
  end
  
  # 予約の更新
  def update
    @room = @reservation.room
    
    if @reservation.update(reservation_params)
      redirect_to own_reservations_path
    else
      render :edit
    end
  end
  
  # 自分の予約一覧
  def own
    @reservations = current_user.reservations.includes(:room).order(created_at: :desc)
  end
  
  # 予約のキャンセル
  def destroy
    @reservation.destroy
    redirect_to own_reservations_path
  end
  
  private
  
  # 新規予約の構築
  def build_new_reservation
    reservation = current_user.reservations.build(reservation_params)
    room = Room.find(params[:reservation][:room_id])
    reservation.room = room
    return reservation
  end

  # 予約idからデータ取得
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # 予約者以外はリダイレクト
  def ensure_owner
    unless @reservation.user_id == current_user.id
      redirect_to own_reservations_path
    end
  end
  
  def reservation_params
    params.require(:reservation).permit(:check_in_date, :check_out_date, :number_of_guests, :room_id, :user_id, :total_price)
  end
end