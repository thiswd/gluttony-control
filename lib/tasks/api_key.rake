namespace :generate do
  desc "Generate a new API key"
  task api_key: :environment do
    api_key = ApiKey.create!
    puts "Generated API KEY: #{api_key.access_token}"
  end
end
