# encoding: utf-8
class Parser
  attr_reader :file

  def initialize(file)
    @file = file
  end
  
  def content
    File.open(@file, "r", :encoding => "windows-1257").read.encode("UTF-8")
  end

  def header
    content.match('VALUES')
  end
end
