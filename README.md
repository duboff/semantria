[![Build Status](https://travis-ci.org/duboff/semantria.svg?branch=v0.0.3)](https://travis-ci.org/duboff/semantria)
[![Coverage Status](https://img.shields.io/coveralls/duboff/semantria.svg)](https://coveralls.io/r/duboff/semantria?branch=master)
[![Dependency Status](https://gemnasium.com/duboff/semantria.svg)](https://gemnasium.com/duboff/semantria)
[![Code Climate](https://codeclimate.com/github/duboff/semantria/badges/gpa.svg)](https://codeclimate.com/github/duboff/semantria)

# Semantria

The goal of this gem is to simplify interaction with Semantia API. Semantria have an official Ruby SDK which is currently more full (coverall all of the API) but is very hard to understand and use. This gem uses httparty to simplify the code. It should be easy to debug and improve.

## Installation

Add this line to your application's Gemfile:

    gem 'semantria'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install semantria

## Usage

```
client = Semantria::Client.new('key', 'secret')

client.check_status # => 200

client.queue_document('Here is some nice test', id) # => queue single document for analysis

client.queue_batch(['Here is some nice test', 'And another one']) # => queue an array of documents for analysis

client.get_processed_documents

client.get_document(id) # => Get a single document by id (string of 10 digits)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/semantria/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
