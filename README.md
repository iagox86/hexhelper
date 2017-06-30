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
puts HexHelper::to_s(str)
```

Which generates:

```
irb(main):001:0> require 'hexhelper'
=> true
irb(main):002:0> str = "This is a test string \x00\x01\x02"
=> "This is a test string \u0000\u0001\u0002"
irb(main):003:0> puts HexHelper::to_s(str)
00000000  54 68 69 73 20 69 73 20 61 20 74 65 73 74 20 73   This.is.a.test.s
00000010  74 72 69 6e 67 20 00 01 02                        tring....
```

It's also possible to indent with the `indent` parameter, and to highlight a
particular offset with the `offset` parameter:

```
irb(main):004:0> puts HexHelper::to_s(str, indent: 4, offset: 0x10)
    00000000  54 68 69 73 20 69 73 20 61 20 74 65 73 74 20 73   This.is.a.test.s
    00000010 <74>72 69 6e 67 20 00 01 02                        tring....
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/iagox86/hexhelper

