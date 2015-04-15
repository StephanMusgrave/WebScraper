require 'open-uri'
require 'nokogiri'
require 'csv'

# store the url to be scraped
url = "https://www.airbnb.co.uk/s/London--United-Kingdom"

# Parse the page with Nokugiri
page = Nokogiri::HTML(open(url))

# scrape the maximum number of pages and store in max_page
page_numbers = []
page.css("div.pagination ul li a[target]").each do |line|
  page_numbers << line.text
end
max_page = page_numbers.max
puts "max_page: #{max_page}"

# initialize empty arrays
name = []
price = []
description = []

# loop once for every page of search results
max_page.to_i.times do |i|

  # open search results page
  url = "https://www.airbnb.co.uk/s/London--United-Kingdom?page=#{i+1}"
  page = Nokogiri::HTML(open(url))

  # store the data in arrays
    # page.css('div.h5.listing-name').each do |line|
    page.css('listing-name').each do |line|
    name << line.text.strip
    puts "name: #{name}"
  end

# <h3 title="Flat in CENTRAL LONDON!" class="h5 listing-name text-truncate row-space-top-1">        
# </h3>
# <div class="text-muted listing-location text-truncate"><a href="/rooms/5676286?s=NiGQ" class="text-normal link-reset">
# </a>
# </div>

  page.css('span.h3.price-amount').each do |line|
    price << line.text
    # puts "price: #{price}"
  end

  page.css('div.text-muted.listing-location.text-truncate').each do |line|
    subarray = line.text.strip.split(/ · /)
    if subarray.length == 3
      description << subarray
    else
      description << [subarray[0], "0 reviews", subarray[1]]
    end
  end

end

# write data to csv file
CSV.open("airbnb_listings.csv", "w") do |file|
  file << ["Listing title", "Price", "Description", "Reviews", "Location"]

  name.length.times do |i|
    file << [name[i], price[i], description[i][0], description[i][1], description[i][2]]
  end
end