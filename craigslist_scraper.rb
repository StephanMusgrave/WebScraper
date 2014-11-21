require 'open-uri'
require 'JSON'

# set API token and URL
auth_token = "b6ae9b063b9409eb915ab1c32b30ad62"
polling_url = "http://polling.3taps.com/poll"

# Specify request parameters
params = {
  auth_token: auth_token,
  anchor: 1526310618
}

# Prepare API request
uri = URI.parse(polling_url)
uri.query = URI.encode_www_form(params)

# Submit request
result = JSON.parse(open(uri).read)

# Display results to screen
puts JSON.pretty_generate result









