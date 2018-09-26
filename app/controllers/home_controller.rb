require 'rest-client'
class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @quote = QuoteService.new().execute
  end

  def create_quotes
    url = 'http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1'
    
    @quote = QuoteService.new().execute(url)
    if params[:source]
      @quote.source = params[:source] 
      @quote.save
    end
  end
end

