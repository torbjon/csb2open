class Parser
  attr_reader :file

  def initialize(file)
    @file = file
  end
  
  def content
    File.open(@file).read
  end
end
