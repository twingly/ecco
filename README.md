# Ecco

[![Build Status](https://travis-ci.org/twingly/ecco.svg?branch=master)](https://travis-ci.org/twingly/ecco)

MySQL 5.6 replication binlog parser using [mysql-binlog-connector-java].

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

    rake maven:dependencies

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

Ecco includes a Docker Compose definition that can be used for this.

Just start it before running the tests

    docker-compose up

*Note: Stop any local mysql servers first as it forwards mysql to localhost:3306.*

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

[mysql-binlog-connector-java]: https://github.com/shyiko/mysql-binlog-connector-java
[GitHub Changelog Generator]: https://github.com/skywinder/github-changelog-generator/
