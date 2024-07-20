require 'sinatra'
require_relative 'scraper'

set :port, 8080

post '/scrape' do
  content_type :json
  request_body = JSON.parse(request.body.read)
  n = request_body['n']
  filters = request_body['filters']

  scraper = YCombinatorScraper.new(n, filters)
  scraper.scrape

  { status: 'success', message: 'Scraping completed successfully' }.to_json
end
