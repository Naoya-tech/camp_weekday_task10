class AreasController < ApplicationController

  def index
    @areas = Area.all
  end

  def search_get
  end



end
