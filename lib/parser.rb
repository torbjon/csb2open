# encoding: utf-8
require 'open-uri'

class Parser
  def initialize(params)
    @file = params[:file]
    @url  = params[:url]
  end
  
  def content
    if !@file.nil?
      File.open(@file, "r", :encoding => "windows-1257").read.encode("UTF-8")
    elsif !@url.nil?
      open(@url).read.force_encoding("windows-1257").encode("UTF-8")
    end
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

  def data_first
    values[0].split('=')[1].gsub('"', "").split(",")
  end
  
  def data_get
    content.split("DATA=")[1].gsub(";", "").split("\r\n").reject(&:empty?) 
  end

  def values
    content.gsub(/\n|\r/, "").split(";").select { |line| line =~ /VALUES/ }
  end

  def header_first
    values[0].split('"')[1]
  end

  def header_rest
    if values[1..-1].length == 2
      first_part  = values[-2].split("=")[1].split(",")
      second_part = values[-1].split("=")[1].split(",")
      first_part.product(second_part).map { |part| part.join(" ").gsub('"', "") }.join(", ")
    end
  end
end

#p = Parser.new(File.expand_path("../../spec/fixtures/bankas_viss.px", __FILE__))
#p.to_csv
