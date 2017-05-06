require_relative '../lib/macbethLines'
url = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"

  def run(url)
    macbeth = MacbethLines.new(url)
    macbeth.line_count
    macbeth.output_data
  end
  
run(url)
