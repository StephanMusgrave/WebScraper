require 'open-uri'
require 'nokogiri'

# store the url to be scraped
url = "https://www.airbnb.co.uk/s/London--United-Kingdom"

# Parse the page with Nokugiri
page = Nokogiri::HTML(open(url))

# Display the listing titles onto the screen
page.css('div.h5.listing-name').each do |line|
  puts line.text
end

# Display the listing prices
page.css('span.h3.price-amount').each do |line|
  puts line.text
end

# Display the listing descriptions
page.css('div.text-muted.listing-location.text-truncate').each do |line|
  puts line.text
end