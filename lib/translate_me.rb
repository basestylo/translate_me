require "translate_me/version"
require 'typhoeus'
require 'nokogiri'
require 'uri'
require 'cgi'

module TranslateMe
  def self.translate word, to, from=""
    url = "http://www.google.es/async/translate?"
    body = URI.encode("async=translate,sl:#{from},tl:#{to},st:#{word},id:1452609152756,_id:tw-async-translate,_pms:s")

    google_response = Typhoeus.post(url, body: body)
    begin
      html = Nokogiri::HTML(JSON.parse(google_response.body.to_s)[1][1])
      response = {
        word: html.css("span")[3].children.text.force_encoding("ISO-8859-1").encode("utf-8"),
        synonyms:  html.css(".tw-bilingual-translation").map{|e| e.text},
        source_language: html.css("span")[5].text
      }
    rescue JSON::ParserError => e
      puts e.message
      puts e.backtrace
      puts "URL: " + url.to_s
      puts "Body: " + body.to_s
      puts "Word: " + word.to_s
    end
    return response || nil
  end

  def self.parse_text text
    puts "GEMA: " + text
    CGI.escape(text)
  end
end
