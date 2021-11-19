require 'open-uri'
require 'nokogiri'
require 'csv'

######### class, id
columnArticle = ".zn__column--idx-2"
columnArticleItem = ".zn__column--idx-2 article .cd__content .cd__headline"
articleTag = "article"
articleLink = "article .link-banner"
articleTitle = ".pg-headline"
articleDate = ".update-time"
articleAuthor = ".metadata__byline__author a:nth-child(1)"
articleImage = "article div img @src"
articleText = "#body-text"
articlePar = ".zn-body__paragraph"
#########

url = 'https://www.rottentomatoes.com'

doc = Nokogiri::HTML(open(url), nil) 

dataSet = []
csvLines = []
names = []
ratings = []
#popular movies list
doc.css('#media-lists > div.layout.media-lists > div > div.js-scores-lists-wrapper.ordered-layout__scores-wrap > div:nth-child(1) > section > text-list > ul').each do |item|
    item.css('.dynamic-text-list__item-title').each do |name|
        names.push(name.inner_html.strip)
    end

    item.css('@slot').each do |percent|
        if item.css('@slot').inner_html.include? "tomatometer-value"
            percentStr = item.css('.b--medium').inner_html.strip
            percentStr.delete! '%'
            percentStr.delete! ' '
            if not percentStr.empty?
                ratings.push(percentStr)
            end
        end
    end
end

for i in 0..ratings.length()
    line = ""
    puts names[i]
    puts ratings[i]
    #line += names[i] + "," + ratings[i] + ";"
    puts line
end
