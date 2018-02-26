module UsersHelper
  def decide_AD()
  if(params[:orderType]=="ASC")
    @type = "DESC"
  else
    @type = "ASC"
  end
  end

  def current_params
    return "?order=#{params[:order]}&orderType=#{params[:orderType]}&level=#{params[:level]}&scale=#{params[:scale]}&field=#{params[:field]}&state=#{params[:state]}&start_date=#{params[:start_date]}&end_date=#{params[:end_date]}&per_page=#{params[:per_page]}&page=#{params[:page]}&potential_level=#{params[:potential_level]}"
  end

  def default_params
    return "?order=id&orderType=ASC&page=1&per_page=30&level=0&field=0&scale=0&state=0&start_date=#{Team.first.created.strftime('%Y-%m-%d')}&end_date=#{Date.today}"
  end
end
