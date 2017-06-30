load '/Users/malaimes/BSG/BSG/BSG-REST/lib/client.rb'

begin
  
  client = BSG::Client.new(ENV['BSG_ACCESS_KEY'])

  msg = client.message_create(destination: 'phone', originator: 'marlin', body: 'message text', msisdn: '380933385258', reference: 'marlin004')

  rescue BSG::ErrorException => ex
  puts
  puts 'An error occured while requesting an Message object:'
  puts

  ex.errors.each do |error|
    puts "  code        : #{error.error}"
    puts "  description : #{error.errorDescription}"
    puts
  end
end

