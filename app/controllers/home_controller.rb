class HomeController < ApplicationController
  def index
    @NUM_DAYS = 7
    @time = Time.now
    @search_days = []
    for i in 0...@NUM_DAYS
      @search_days.append(@time.strftime("%Y-%m-%d"))
      @time += 86400
    end

    @d = get_day
    @doc_string = Nokogiri::HTML(open(URI.escape("http://www.villagevoice.com/concerts/#/date:" + @search_days[@d.to_i] + "/")))
  end

  def get_day
    @e = params[:date].to_i
    @e = 0 if @e.nil?
    @e
  end
end
