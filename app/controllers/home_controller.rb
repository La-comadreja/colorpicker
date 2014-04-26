class HomeController < ApplicationController
  def index
    @NUM_DAYS = 7
    @time = Time.now
    @search_days = []
    for i in 0...@NUM_DAYS
      @search_days.append(@time.strftime("%d+%b+%Y"))
      @time += 86400
    end

    # pages directory scrapes from http://www.mysocialist.com/concerts
    doc_string = Nokogiri::HTML(open("pages/mysocialist.txt"))
    @sections = doc_string.css(".listingRow")
    if params[:date].nil?
      @date = 0
    else
      @date = params[:date].to_i
    end
  end
end
