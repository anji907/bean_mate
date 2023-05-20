require 'open-uri'

# カフェのplace_idを取得するメソッド
def get_place_ids_from_api
  # キーバリューをURLエンコードする
  query = URI.encode_www_form(
    query: "代官山",
    type: "cafe",
    language: "ja",
    key: ENV["GOOGLE_API_KEY"]
  )
  url = URI "https://maps.googleapis.com/maps/api/place/textsearch/json?#{query}"

  loop do
    # Net::HTTPインスタンスを生成する
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    json_data = JSON.parse(response.body)

    place_ids = json_data["results"].map { |result| result["place_id"] }
    
    place_ids.each do |place_id|
      get_cafe_detail_from_place_id(place_id)
    end

    # 次のページがあれば、URLを更新する
    if json_data["next_page_token"]
      next_page_token = json_data["next_page_token"]
      url = URI "https://maps.googleapis.com/maps/api/place/textsearch/json?pagetoken=#{next_page_token}&#{query}"
    else
      break
    end
  end
end


def get_cafe_detail_from_place_id(place_id)
  query = URI.encode_www_form(
    place_id: place_id,
    language: "ja",
    key: ENV["GOOGLE_API_KEY"]
  )
  url = URI "https://maps.googleapis.com/maps/api/place/details/json?#{query}"
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)

  response = https.request(request)
  json_data = JSON.parse(response.body)

  result = json_data["result"]
  place_id = result["place_id"]
  name = result["name"]
  description = result["editorial_summary"]["overview"] if result["editorial_summary"]
  address = result["formatted_address"]
  website = result["website"]
  latitude = result["geometry"]["location"]["lat"]
  longitude = result["geometry"]["location"]["lng"]

  cafe = Cafe.find_or_initialize_by(place_id: place_id)
  cafe.update!(name: name, description: description, address: address, website: website, latitude: latitude, longitude: longitude)

  get_place_photo(cafe, result["photos"][0]["photo_reference"]) if result["photos"]
end

def save_place_photo
  cafes = Cafe.all

  cafes.each do |cafe|
    next if cafe.images.attached?
    query = URI.encode_www_form(
      place_id: cafe.place_id,
      language: "ja",
      key: ENV["GOOGLE_API_KEY"]
    )
    url = URI "https://maps.googleapis.com/maps/api/place/details/json?#{query}"
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    next if JSON.parse(response.body)["result"]["photos"].nil?
    photo_reference = JSON.parse(response.body)["result"]["photos"][0]["photo_reference"]

    query = URI.encode_www_form(
      photo_reference: photo_reference,
      maxwidth: 400,
      key: ENV["GOOGLE_API_KEY"]
    )
    url = "https://maps.googleapis.com/maps/api/place/photo?#{query}"
    photo_data = URI.open(url).read

    cafe.images.attach(io: StringIO.new(photo_data), filename: "#{cafe.name}.jpg")
  end
end