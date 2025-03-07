class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  
  def index
    @rooms = Room.all
  end
  
  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(room_params)
    @room.user = current_user
    if @room.save
      redirect_to @room
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @room.update(room_params)
      redirect_to @room
    else
      render :edit
    end
  end
  
  def destroy
    @room.destroy
    redirect_to rooms_path
  end
  
  # 現在のユーザー所有の施設を指定
  def own
    @rooms = Room.where(user_id: current_user.id)
  end
  
  private

  def set_room
    @room = Room.find(params[:id])
  end

  # 施設用パラメータ
  def room_params
    if params[:room].present?
      params.require(:room).permit(:name, :address, :price, :description, :image)
    else
      params.permit(:name, :address, :price, :description, :image)
    end
  end
end