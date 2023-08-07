# RemoteI18n

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'remote-i18n', require: 'remote_i18n'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install remote-i18n

## Usage

- This gem is made on top of existing `I18n` gem.
- This gem uses existing "Simple" backend as a base for new "Remote" backend. It needs to be extended further to use "Key-Pair" backend with the remote support (TODO for future versions)
- To use it, manually provide the "remote locations URLs" from where translations are to be fetched.
- You can also set the "fallback locations" as you simply do with the normal `I18n` implementation.
- Using Rails - Generate a config file using `rails generate remote_i18n_config`, or create your own initializer.
- Example code is below:
```
# Remote URLs where the translation files are hosted
I18n.config.remote_urls = [
  'https://raw.githubusercontent.com/g1stavo/rails-i18n/master/config/locales/en.yml',
  'https://raw.githubusercontent.com/g1stavo/rails-i18n/master/config/locales/pt-BR.yml'
]

# Fallback location for local translation file(s)
I18n.load_path = [
  File.expand_path('./locales/en.yml')
]

# Example - translate in English
puts I18n.translate(:confirm, locale: :en)

# Example - translate in Portuguese
puts I18n.translate(:confirm, locale: 'pt-BR')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/schnmudgal/remote_i18n. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/schnmudgal/remote_i18n/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RemoteI18n project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/remote_i18n/blob/master/CODE_OF_CONDUCT.md).
