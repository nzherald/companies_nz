# NZ::Companies

This gem is designed for working with the New Zealand Companies Office
API.

To use this gem you will need:

A BusinessData account with the Companies Office, which will provide you
with:

1. An authentication key id (`key_id`)

2. A secret key (`secret_key`)

This gem also assumes that you are using the latest (v2.0) versions of
the entity search and entity details endpoints (the default
at the time of writing).

Visit the [BusinessData](http://www.business.govt.nz/businessdata) site
for more information, or contact the very helpful Companies Office team.

For now this gem only covers the authorization header HMAC SHA 256
signing and just returns the JSON for you to make of what you will.
Future versions may structure the data in Structs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nz-companies'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nz-companies

## Usage

```
  # to use the test environment (www.eat.businessdata.govt.nz)
  client = NZ::Companies::Client.new(key_id: YOUR_KEY_ID, secret_key: YOUR_SECRET_KEY, test: true)
  # to use the live environment
  client = NZ::Companies::Client.new(key_id: YOUR_KEY_ID, secret_key: YOUR_SECRET_KEY))

  # to search for entities with 'Mega' in the name
  resp = client.search_entities 'Mega'    # returns a JSON parsed as a Ruby hash

  # to search for roles by an individual's name
  resp = client.search_roles 'John Archibald Banks'

  # to get company details by company number
  resp = client.entity_details 1947574
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/nz-companies/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
