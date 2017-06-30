load '/Users/malaimes/BSG/BSG/BSG-REST/lib/client.rb'

begin
  
  client = BSG::Client.new(ENV['BSG_ACCESS_KEY'])

  msg = client.viber_create("messages":[{"to":[{"msisdn":"380933385258"}],"text":"My Viber messages is shinier than your SMS messages","alpha_name":"BSG","is_promotional":false,"options": {"viber": {"img": "http://my-cool-webpage.com/logo.png", "caption": "Join us!", "action": "http://my-cool-webpage.com", "alt_route": {"originator":"marlin", "text": "some text"}}}}])

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
