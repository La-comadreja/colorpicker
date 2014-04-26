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
    @date = 0
    if !params[:date].nil?
      @date = params[:date].to_i
    end

    @links = []
    @events = []
    @sections.each do |s|
      t = s.to_s.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
      if t.include?("+on+" + @search_days[@date])
        @events.append(t)
        @links.append("http://www.mysocialist.com" + s.css("a")[0].to_s.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '').split("\"")[1])    
      end
    end

    @addresses = []
    @links.each do |l|
      doc_string = Nokogiri::HTML(open(l))
      @addresses.append(doc_string.css(".event-venue-data")[0].to_s.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''))
    end
  end
end
