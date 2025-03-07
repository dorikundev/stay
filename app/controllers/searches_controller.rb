class SearchesController < ApplicationController
    # 検索
    def search
      @rooms = Room.search(params)
      render 'rooms/index'
    end
    
end
