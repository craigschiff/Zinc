class Analyzer
  attr_accessor :char_hash, :speech_data, :version

  def initialize(url, version)
    xml_data = Nokogiri::HTML(open(url))
    @speech_data = xml_data.xpath('//speech')
    @char_hash = {}
    @version = version
  end

  def line_count
    speech_data.each do |speech|
      speaker = find_speaker(speech)
      lines = find_lines(speech)
      add_to_store(speaker, lines) if speaker != "All"
    end
    save_data
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

  def save_data
    char_hash.each do |char, count|
      character = Character.find_or_create_by(name: char)
      LineCount.find_or_create_by(count: count, character: character, version: version)
    end
  end

  def self.call(url, version)
    self.new(url, version).line_count
  end
end
