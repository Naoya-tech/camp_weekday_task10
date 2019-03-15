class AreasController < ApplicationController
  include AreasHelper

  def index
    @areas = Area.all
  end

  def search_get
  end

  def search
    @area = Area.new
    uri = URI.parse("http://zipcloud.ibsnet.co.jp/api/search?zipcode=#{params[:zipcode]}")
    response = Net::HTTP.get_response(uri)
    @result = JSON.parse(response.body)
    api
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      flash[:notice] = "地域を登録しました。"
      redirect_to "/"
    else
      render "new"
    end
  end

  private

  def area_params # ストロングパラメータを定義する
    params.require(:area).permit(:zipcode, :address1, :address2, :address3, :kana1, :kana2, :kana3, :prefcode, :introduction)
  end

end
