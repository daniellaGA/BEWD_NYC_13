require 'rest-client'
require 'json'
require 'pry'

url = 'http://api.whitehouse.gov/v1/petitions.json'

response = RestClient.get(url)
parsed_response = JSON.parse(response)


petitions = parsed_response['results']

titles = petitions.map do |petition|
  petition ['title']
end

titles.each do |title|
  puts title
end