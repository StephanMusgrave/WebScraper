require 'open-uri'
require 'nokogiri'

url = "https://www.airbnb.co.uk/s/London--United-Kingdom"
page = Nokogiri::HTML(open(url))
