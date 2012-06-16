# encoding: utf-8
require 'net/http'
require 'uri'

class Parser
  attr_reader :file

  def initialize(file)
    @file = file
  end
  
  def content
    File.open(@file, "r", :encoding => "windows-1257").read.encode("UTF-8")
  end

  def header
    "#{header_first}, #{header_rest}"    
  end

  def data
    data_first.each_with_index.map do |data, idx| 
      "#{data_first[idx]}, #{data_get[idx].strip.gsub(" ", ", ")}"
    end
  end

  def to_csv
    puts header
    puts data
  end

  private

  def data_first(val = "")
    values[0].split('=')[1].gsub('"', "").split(",")
  end
  
  def data_get
    content.split("DATA=")[1].gsub(";", "").split("\r\n").reject {|x| x.empty?}
  end

  def values
    x = content.gsub("\n", "").gsub("\r", "").split(";")    
    values = []
    x.each { |line| values << line if line =~ /VALUES/ }
    values 
  end

  def header_first
    values[0].split('"')[1]
  end

  def header_rest
    if values[1..-1].count >= 1
      values[1].split("=")[1].split(",").map do |result|
        values[-1].split("=")[1].split(",").each_with_index.map do |result2, idx|
          "#{result.gsub('"', "")} #{result2.gsub('"', "")}"
        end
      end.join(", ") 
    end
  end
end

#p = Parser.new(File.expand_path("../../spec/fixtures/bankas_viss.px", __FILE__))
#p.to_csv
