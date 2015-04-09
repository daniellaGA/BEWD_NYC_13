require 'pry'
require 'rightsignature'
require 'rest-client'
require 'active_support/inflector'

client = RightSignature::Connection.new(api_token: "5aMz0anPzNcTZk7xpNW1g4wFvAJQE92VjX4A3r63")

page = 1
documents = []

while page
  documents_data = client.documents_list(per_page: 50, page: page, search: 'NYC', state: 'completed')
  if documents_data['page']['documents']
    documents_data = [documents_data['page']['documents']['document']].flatten
    documents_data.each do |document_data|
      if document_data['signed_pdf_url']
        document = {
          url: document_data['signed_pdf_url'],
          guid: document_data['guid'],
          filename: document_data['subject'],
          signer: document_data['recipients']['recipient'].select { |recipient| recipient['role_id'] == 'signer_B' }.first['name']
        }
        begin
          filename = "contracts/#{document[:signer].parameterize}_#{document[:filename].parameterize}.pdf"
          url = URI.decode(document[:url])
          response = RestClient.get(url)
          File.write(filename, response)
          puts "Downloaded #{filename}"
        rescue => exception
          binding.pry
        end
      end
    end
    page += 1
    puts "Processing page #{page}"
  else
    page = nil
  end
end