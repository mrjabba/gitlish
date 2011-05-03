require 'nokogiri'

class Delishreformat
  def initialize(*args)
    puts "start"
    @file_path = "delicious-20101217.htm"
    f = File.open(@file_path)
    doc = Nokogiri::XML(f)
    nodes = doc.xpath("//DT/A")
    nodes.each { |element| 
      puts "<bookmark><title>#{element.text}</title><url>#{element['HREF']}</url><tags>#{element['TAGS']}</tags></bookmark>" 
    }
    f.close    
    puts "end"
  end
end

Delishreformat.new
