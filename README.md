# Repository archived ☠️

This project is no longer used by Twingly, and has therefore been archived.

---

# Ecco

[![GitHub Build Status](https://github.com/twingly/ecco/workflows/CI/badge.svg?branch=master)](https://github.com/twingly/ecco/actions)

MySQL (5.7 and 8.0) replication binlog parser using [mysql-binlog-connector-java].

## Installation

Add this line to your application's Gemfile:

```ruby
gem "ecco"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ecco

## Usage

```ruby
require "ecco"

hostname = "localhost" # Optional
port     = 3306        # Optional
username = "username"
password = "password"

client = Ecco::Client.new(hostname: hostname, port: port, username: username, password: password)

client.on_row_event do |row_event|
  type     = row_event.type
  database = row_event.database
  table    = row_event.table
  rows     = row_event.rows

  next unless database == "FooDatabase"
  next unless table == "FooTable"

  second_column = rows.first[1]

  puts "Row event: #{database} #{table} #{type} #{second_column}"
end

client.on_save_position do |filename, position, event_type_name|
  puts "Saved #{event_type_name} event: #{filename} #{position}"
end

client.on_communication_failure do |client, error|
  puts error.message
end

# Optionally set a starting position
client.set_binlog_filename("mysql-bin.000009")
client.set_binlog_position(276753)

client.start
```

## Development

To download a new version of [mysql-binlog-connector-java]

    bundle exec rake maven:dependencies

Note: You need Maven to download

    brew install maven

Run the tests

    bin/specs

For an interactive prompt

    bin/console

To install this gem onto your local machine

    bundle exec rake install

### Integration tests

The integration tests don't run by default. To run all the tests, including integration, use

    bin/all_specs

The tests needs a MySQL server with replication enabled.

Ecco includes multiple Docker Compose definitions that can be used for this, one per supported MySQL version.

Start the desired version before running the tests:

```shell
# MySQL 5.7
docker-compose -f docker-compose-mysql-base.yml -f docker-compose-mysql-5-7.yml up

# MySQL 8.0
docker-compose -f docker-compose-mysql-base.yml -f docker-compose-mysql-8-0.yml up
```

*Note: Stop any local MySQL server first, otherwise there will be port collisions*

## Release

To release a new version, make a commit bumping the version number in `version.rb`, and then run

    bundle exec rake release

which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Update the changelog with [GitHub Changelog Generator]:

    github_changelog_generator

Preparations you might have to do:

* `gem install github_changelog_generator` if you don't have it
* set `CHANGELOG_GITHUB_TOKEN` to a personal access token to increase your GitHub API rate limit

Make a commit with the changelog changes and push.

## License

The gem is available as open source under the terms of the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

[mysql-binlog-connector-java]: https://github.com/osheroff/mysql-binlog-connector-java
[GitHub Changelog Generator]: https://github.com/skywinder/github-changelog-generator/
