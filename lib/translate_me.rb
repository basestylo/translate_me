require "translate_me/version"
require 'typhoeus'
require 'nokogiri'
require 'uri'

module TranslateMe
  def self.translate word, to, from=""
    url = parse_url("http://www.google.es/async/translate?")
    body = "async=translate,sl:#{from},tl:#{to},st:#{parse_text(word)},id:1452609152756,_id:tw-async-translate,_pms:s"

    google_response = Typhoeus.post(url, body: body)
    begin
      html = Nokogiri::HTML(JSON.parse(google_response.body).last.last)
      response = {
        word: html.css("span")[3].children.text,
        synonyms:  html.css(".tw-bilingual-translation").map{|e| e.text}
      }    
    rescue JSON::ParserError => e
      puts e.message
      puts e.backtrace
      puts "URL: " + url
      puts "Body: " + body
    end	
    return response || nil
  end

  def self.parse_url url
    URI.parse(url)
  end

  def self.parse_text text
    text.downcase.gsub(",","%2C").gsub("?","%3F")
  end
end
