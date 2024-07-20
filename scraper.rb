require 'nokogiri'
require 'httparty'
require 'csv'

class YCombinatorScraper
  BASE_URL = 'https://www.ycombinator.com/companies'

  def initialize(n, filters)
    @n = n
    @filters = filters
    @companies = []
  end

  def scrape
    page = 1
    while @companies.size < @n
      url = "#{BASE_URL}?page=#{page}"
      response = HTTParty.get(url)
      parse_page(response.body)
      page += 1
      break if response.body.include?('No more companies')
    end
    @companies = @companies.first(@n)
    fetch_additional_details
    save_to_csv
  end

  private

  def parse_page(html)
    doc = Nokogiri::HTML(html)
    doc.css('.company-card').each do |company_card|
      company = {
        name: company_card.css('.company-name').text.strip,
        location: company_card.css('.company-location').text.strip,
        description: company_card.css('.company-description').text.strip,
        yc_batch: company_card.css('.company-batch').text.strip
      }
      @companies << company
    end
  end

  def fetch_additional_details
    @companies.each do |company|
      # Fetch additional details like website, founders, LinkedIn URLs
      # Use Nokogiri and HTTParty to parse the additional details page
    end
  end

  def save_to_csv
    CSV.open('companies.csv', 'w') do |csv|
      csv << ['Name', 'Location', 'Description', 'YC Batch', 'Website', 'Founders', 'LinkedIn URLs']
      @companies.each do |company|
        csv << [
          company[:name],
          company[:location],
          company[:description],
          company[:yc_batch],
          company[:website],
          company[:founders].join('; '),
          company[:linkedin_urls].join('; ')
        ]
      end
    end
  end
end
