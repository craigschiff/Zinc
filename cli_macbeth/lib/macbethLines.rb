require 'nokogiri'
require 'byebug'
require 'open-uri'

class MacbethLines
  attr_accessor :char_hash, :speech_data

  def initialize(url)
    xml_data = Nokogiri::HTML(open(url))
    @speech_data = xml_data.xpath('//speech')
    @char_hash = {}
    # line_count(data)
  end

  def line_count
    speech_data.each do |speech|
      speaker = find_speaker(speech)
      lines = find_lines(speech)
      add_to_store(speaker, lines) if speaker != "All"
    end
  end

  def find_speaker(speech)
    speaker = speech.children[1].children.text
    capitalize_speaker(speaker)
  end

  def capitalize_speaker(speaker)
    speaker.split(' ').map{|word| word.capitalize}.join(' ')
  end

  def find_lines(speech)
    lines = 0
    speech.children.each do |line|
      if line.name == 'line'
        lines += 1
      end
    end
    lines
  end
  def add_to_store(speaker, lines)
    if char_hash[speaker]
      char_hash[speaker] += lines
    else
      char_hash[speaker] = lines
    end
  end

  def output_data
    sorted_by_line = char_hash.sort_by {|key, value| value}.reverse.to_h
    sorted_by_line.each do |char, count|
      puts "#{count} #{char}"
    end
  end

end
