# encoding: utf-8
require_relative "../lib/parser"

describe Parser do
  before do
    @file = File.expand_path("../fixtures/bankas_viss.px", __FILE__)
    # @file = open("http://data.csb.gov.lv/DATABASE/ekfin/%C4%AAstermi%C5%86a%20statistikas%20dati/Banku%20r%C4%81d%C4%ABt%C4%81ji/BR0010m.px"
    @parser = Parser.new(@file)
  end

  it "expects input file" do
    Parser.new("blabla").should_not raise_error(ArgumentError)
  end

  describe ".content" do
    it "returns passed in file content" do
      @parser.content.should =~ /Hey from px file/
    end
  end

  describe ".header" do
    it "should return headers" do
      @parser.header.should == "Gads, Piesaistītie noguldījumi kredītiestādēs ilgtermiņa, Piesaistītie noguldījumi kredītiestādēs īstermiņa, Izsniegtie kredīti kredītiestādēs ilgtermiņa, Izsniegtie kredīti kredītiestādēs īstermiņa"
    end
  end

  describe ".data" do
    it "returns data" do
      @parser.data[0].should eq("1993, 58.7, 34.8, 39.3, 86")
    end
  end
end
