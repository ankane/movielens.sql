require "csv"

path = ARGV[0]

occupations = []
CSV.foreach "#{path}/u.occupation", col_sep: "|" do |row|
  occupations << {id: occupations.size + 1, name: row[0].capitalize}
end

occupation_ids_by_name = Hash[ occupations.map{|o| [o[:name], o[:id]] } ]

users = []
CSV.foreach "#{path}/u.user", col_sep: "|" do |row|
  users << {id: row[0].to_i, age: row[1].to_i, gender: row[2], occupation_id: occupation_ids_by_name[row[3].capitalize], zip_code: row[4]}
end

ratings = []
CSV.foreach "#{path}/u.data", col_sep: "\t" do |row|
  ratings << {id: ratings.size + 1, user_id: row[0].to_i, movie_id: row[1].to_i, rating: row[2].to_i, rated_at: Time.at(row[3].to_i)}
end

genres = []
CSV.foreach "#{path}/u.genre", col_sep: "|" do |row|
  genres << {id: genres.size + 1, name: row[0]} if row[0] && row[0] != "unknown"
end

movies = []
genres_movies = []
CSV.foreach "#{path}/u.item", col_sep: "|", encoding: "windows-1251:utf-8" do |row|
  release_date = row[2] ? Date.parse(row[2]) : nil
  movies << {id: row[0].to_i, title: row[1], release_date: release_date}
  movie_genres = []
  row[6..-3].each_with_index do |v, i|
    if v == "1"
      genres_movies << {id: genres_movies.size + 1, movie_id: row[0].to_i, genre_id: genres[i][:id]}
    end
  end
end

def quoted_value(v)
  case v
  when String
    "'#{v.gsub("'", "''")}'"
  when Time
    "'#{v.strftime("%Y-%m-%d %H:%M:%S")}'"
  when Date
    "'#{v.strftime("%Y-%m-%d")}'"
  when nil
    "NULL"
  else
    v
  end
end

def values(records)
  records.map{|r| "(#{r.values.map{|v| quoted_value(v) }.join(",")})" }.join(",")
end

puts %Q!
BEGIN;

DROP TABLE IF EXISTS occupations;
CREATE TABLE occupations (
  id integer NOT NULL,
  name varchar(255),
  PRIMARY KEY (id)
);
INSERT INTO occupations VALUES #{values(occupations)};

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id integer NOT NULL,
  age integer,
  gender char(1),
  occupation_id integer,
  zip_code varchar(255),
  PRIMARY KEY (id)
);
INSERT INTO users VALUES #{values(users)};

DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (
  id integer NOT NULL,
  user_id integer,
  movie_id integer,
  rating integer,
  rated_at timestamp,
  PRIMARY KEY (id)
);
INSERT INTO ratings VALUES #{values(ratings)};

DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
  id integer NOT NULL,
  title varchar(255),
  release_date date,
  PRIMARY KEY (id)
);
INSERT INTO movies VALUES #{values(movies)};

DROP TABLE IF EXISTS genres;
CREATE TABLE genres (
  id integer NOT NULL,
  name varchar(255),
  PRIMARY KEY (id)
);
INSERT INTO genres VALUES #{values(genres)};

DROP TABLE IF EXISTS genres_movies;
CREATE TABLE genres_movies (
  id integer NOT NULL,
  movie_id integer,
  genre_id integer,
  PRIMARY KEY (id)
);
INSERT INTO genres_movies VALUES #{values(genres_movies)};

COMMIT;
!.strip
