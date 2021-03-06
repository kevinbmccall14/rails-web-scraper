require 'rest-client'

class StaticPagesController < ApplicationController
  def index
    @goals = [300, 300, 300, 300, 150, 150, 100, 100, 100, 50, 0, 0]
    @names = []
    @counts = []
    data = Net::HTTP.get('treeo.vote', '/__totals')
    html_doc = Nokogiri::HTML(data)
    array = html_doc.css('pre').children.text.split("\n")
    array.each do |a|
      key_val = a.gsub(/\s+/, "")
      value = key_val.split('=>')
      @names << value[1] if value[0] == "[name]"
      @counts << value[1] if value[0] == "[treeoCount]"
    end
    @data = {}
    @names.each_with_index do |name, idx|
      @data[name] = @counts[idx]
    end
  end
end
