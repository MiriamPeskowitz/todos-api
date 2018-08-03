module RequestSpecHelper
  #parse JSON response to Ruby Hash
  def json
    JSON.parse(response.body)
  end 
end 

