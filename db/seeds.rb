require 'open-uri'
require 'json'

puts "cleaning database..."
Bookmark.destroy_all
Movie.destroy_all
puts "database is clean"

url = "http://tmdb.lewagon.com/movie/top_rated"
10.times do |i|
  puts "importing movies from page #{i + 1}"
  movies = JSON.parse(open("#{url}?page=#{i + 1}").read)['results']
  movies.each do |movie|
    puts "Creating #{movie['title']}"
    base_poster_url = "https://image.tmdb.org/t/p/original"
    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "#{base_poster_url}#{movie['backdrop_path']}",
      rating: movie['vote-average']
    )
  end
end

puts "Movies created"