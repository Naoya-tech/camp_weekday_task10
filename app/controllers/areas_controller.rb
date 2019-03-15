class AreasController < ApplicationController

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
    if @result["message"] == nil
        @area.zipcode = @result["results"][0]["zipcode"]
        @area.address1 = @result["results"][0]["address1"]
        @area.address2 = @result["results"][0]["address2"]
        @area.address3 = @result["results"][0]["address3"]
        @area.prefcode = @result["results"][0]["prefcode"]
        @area.kana1 = @result["results"][0]["kana1"]
        @area.kana2 = @result["results"][0]["kana2"]
        @area.kana3 = @result["results"][0]["kana3"]
        render :new
    elsif @result["message"] == "パラメータ「郵便番号」の桁数が不正です。"
      @message = @result["message"]  
      render :search_get
    elsif @result["message"] == "必須パラメータが指定されていません。"
      @message = @result["message"] 
      render:search_get
    end
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      flash[:notice] = "地域を登録しました。"
      redirect_to areas_index_path
    else
      render "new"
    end
  end

  private

  def area_params # ストロングパラメータを定義する
    params.require(:area).permit(:zipcode, :address1, :address2, :address3, :kana1, :kana2, :kana3, :prefcode, :introduction)
  end

end
