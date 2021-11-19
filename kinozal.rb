require 'open-uri'

url = 'http://kinozal.tv'
html = URI.open(url)

require 'nokogiri'

# doc = Nokogiri::HTML(html,  nil, Encoding::UTF_16.to_s)
doc = Nokogiri::HTML(html)

lines = Array[]

# get titles
titles = doc.css('#main div.content div.mn2_content div.tp1_border .tp1_title')
  
titles.each do |titles|
  title = titles.css('a').inner_html.strip

  lines.push(title)
end

i = 0
descrs = doc.css('#main div.content div.mn2_content div.tp1_border div.tp1_desc')
descrs.each do |desc|
  descT = desc.css('div.tp1_desc2').inner_html.strip
  descT.slice! "<b>"
  descT.slice! "</b>"
  lines[i]+= " | "
  lines[i]+= descT
  i = i+1
end

lines.each do |line|
    open('data1.csv', 'a') { |f| 
        f.puts line
    }
end
