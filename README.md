# MovieLens.sql

The [MovieLens](http://grouplens.org/datasets/movielens/) database in SQL

For easy importing to PostgreSQL, MySQL, SQLite, and others

## How to Use

Create a new database and run [movielens.sql](https://raw.githubusercontent.com/ankane/movielens.sql/master/movielens.sql)

#### PostgreSQL

```sh
createdb movielens
curl https://raw.githubusercontent.com/ankane/movielens.sql/master/movielens.sql | psql -d movielens
```

#### MySQL

```sh
mysql -e 'create database movielens;'
curl https://raw.githubusercontent.com/ankane/movielens.sql/master/movielens.sql | mysql -u root movielens
```

#### SQLite

```sh
curl https://raw.githubusercontent.com/ankane/movielens.sql/master/movielens.sql | sqlite3 movielens.sqlite3
```

## How to Generate

[Download](http://grouplens.org/datasets/movielens/) a MovieLens data set and run

```ruby
ruby generate.rb path/to/ml-100k > movielens.sql
```
