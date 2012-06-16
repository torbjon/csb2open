# encoding: utf-8

require_relative "../lib/parser"

describe Parser do
  it "expects input file" do
    Parser.new("blabla").should_not raise_error(ArgumentError)
  end

  describe ".content" do
    before do
      @file = File.expand_path("../fixtures/bankas_viss.px", __FILE__)
    end

    it "returns passed in file content" do
      parser = Parser.new(@file)
      parser.content.should =~ /Hey from px file/
    end
  end
end
