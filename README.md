# Hexhelper

This gem simply makes it easy to dump a binary string as nicely formatted hex.

I found myself copying and pasting this code/project to a million different
projects, so I thought it'd make sense to create a gem out of it.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hexhelper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hexhelper

## Usage

Using it is simple!

```ruby
require 'hexhelper'

str = "This is a test string\x00\x01\x02"
puts Hexhelper::to_s(str)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/iagox86/hexhelper

