require "lita"
require "net/http"
require "nokogiri"

module Lita
  module Handlers
    class Pun < Handler
      route(/^give\s+me\s+a\s+pun/i, :pun, command: true, help: {
        "give me a pun" => "Makes the bot send a random pun."
      })

      route(/^what'?s\s+the\s+pun\s+of\s+the\s+day/i, :pun_of_the_day, command: true, help: {
	"what's the pun of the day" => "Asks the bot to get the pun of the day."
      })

      def pun(response)
	#Get a random pun
	pun = build_pun_response("http://www.punoftheday.com/cgi-bin/randompun.pl")
        response.reply(pun)
      end

      def pun_of_the_day(response)
	#Get the pun of the day
	pun = build_pun_response("http://www.punoftheday.com/")
	response.reply(pun)
      end

      def build_pun_response(url)
	#Build the HTTP request
	uri = URI(url)
	source = Net::HTTP.get(uri)

	#Parse out the actual pun text
	html_doc = Nokogiri::HTML(source)
	pun = html_doc.css("div[class='dropshadow1']").css("p").text
	return pun
      end
    end

    Lita.register_handler(Pun)
  end
end
