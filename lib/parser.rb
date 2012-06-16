require "iconv"

class Parser
  attr_reader :file

  def initialize(file)
    @file = file
  end
  
  def content
    file = File.open(@file).read
    x = ::Iconv.iconv("UTF-8", "latin1", file)
    puts x 
  end
end
