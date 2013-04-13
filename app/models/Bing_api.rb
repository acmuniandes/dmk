#Ultra simple wrapper for the Bing Image Search API
class BingAPI





  #
  # Given a query string, returns the images that
  # bing image search matches as similar. Returns max #{limit}
  # images
  #
  def BingAPI.get_images(query, limit)
    u = '5MoQWsdQ6EbW78VA8YhsS1snfI6YIvbOMTzoVT+GXqs='
    url="api.datamarket.azure.com"

    query=URI.escape(query)
    http = Net::HTTP.new(url,443)

    http.use_ssl = true



    http.start do |http_request|

      req = Net::HTTP::Get.new("/Data.ashx/Bing/Search/v1/Image?Query=%27#{query}%27&$top=#{limit}&$format=JSON")
      req.basic_auth u, u

      @resp = http_request.request(req)

    end


  end

end