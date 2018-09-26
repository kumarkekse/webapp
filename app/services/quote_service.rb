class QuoteService
  
  def api_call(url)
    if url.present?
      response_conversion(RestClient.get url)
    else
      response_conversion(RestClient.get 'http://quotesondesign.com/wp-json/posts')      
    end
  end

  def response_conversion(response)
    result = JSON.parse(response)
    @r = result.first
  end

  def execute(url = nil)
    api_call(url)
    attr = quote_data(@r)
    @quote = Quote.find_by_title_and_content(attr['title'], attr['content']) || Quote.create(attr)
  end

  def quote_data(data)
    attr = { title: data['title'], content: data['content'], link: data['link'] }
    attr.merge({ source: data['custom_meta']['Source'] }) if data['custom_meta'].present?
    attr
  end

end