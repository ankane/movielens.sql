# MovieLens.sql

The [MovieLens](https://grouplens.org/datasets/movielens/) database in SQL

For easy importing to PostgreSQL, MySQL, SQLite, and others

## How to Use

Clone this repo:

```sh
git clone https://github.com/ankane/movielens.sql.git
cd movielens.sql
```

Download the [MovieLens 100k dataset](https://grouplens.org/datasets/movielens/100k/), unzip, and run:

```sh
ruby generate.rb path/to/ml-100k > movielens.sql
```

Then import it into your database with one of the commands below.

#### PostgreSQL

```sh
createdb movielens
psql -d movielens < movielens.sql
```

#### MySQL

```sh
mysqladmin create movielens
mysql -u root movielens < movielens.sql
```

#### SQLite

```sh
sqlite3 movielens.sqlite3 < movielens.sql
```
