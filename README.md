# MovieLens.sql

The [MovieLens](http://grouplens.org/datasets/movielens/) database in SQL

For easy importing to PostgreSQL, MySQL, SQLite, and others

## How to Use

Create a new database and run [movielens.sql](https://raw.githubusercontent.com/ankane/movielens.sql/master/movielens.sql)

#### PostgreSQL

```sh
wget https://raw.githubusercontent.com/ankane/movielens.sql/master/movielens.sql
createdb movielens
psql -d movielens < movielens.sql
```

#### MySQL

```sh
wget https://raw.githubusercontent.com/ankane/movielens.sql/master/movielens.sql
mysql -e 'create database movielens;'
mysql -u root movielens < movielens.sql
```

#### SQLite

```sh
wget https://raw.githubusercontent.com/ankane/movielens.sql/master/movielens.sql
sqlite3 movielens.sqlite3 < movielens.sql
```

## How to Generate

[Download](http://grouplens.org/datasets/movielens/) a MovieLens data set and run

```ruby
ruby generate.rb path/to/ml-100k > movielens.sql
```
