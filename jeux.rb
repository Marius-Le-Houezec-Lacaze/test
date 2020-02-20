require 'nokogiri'
require 'open-uri'
require 'csv'
require 'json'

PAGE_URL = 'https://jeuxsoc.fr'

CSV.foreach("jeux.csv") do |row|
  jeux = []
  page  = Nokogiri::HTML(open(PAGE_URL + row[0]))
  title , annee, player, age, time, theme= ""
  puts "============="

  page.xpath("//h1").each do |w|
    title = w.text
  end

  page.xpath("//tr[7]/td[2]").each do |w|
    annee = w.text
  end

  page.xpath("//tr[8]/td[2]").each do |w|
    player =  w.text
  end

  page.xpath("//tr[9]/td[2]").each do |w|
    age = w.text
  end


  page.xpath("//tr[10]/td[2]").each do |w|
    time = w.text
  end

  page.xpath("//tr[11]/td[2]").each do |w|
    theme = w.text
  end

  if annee.to_i > 0
  hash =
    { 
  :title => title,
  :year => annee,
  :joueur => player,
  :age => age,
  :time => time,
  :theme => theme
  }
end
File.open("game.txt","a") do |f|
  f << hash.to_s + "\n"
end
end