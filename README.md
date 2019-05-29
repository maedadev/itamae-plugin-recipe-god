# Itamae::Plugin::Recipe::God

itamae recipe for god process monitoring framework

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-recipe-god'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-recipe-god

## Usage

Include this recpie as:

    include_recipe 'god'

This recipe will install god and generate the following files.

* /etc/god/master.conf

  This is the master file for god configuration. It load all cofiguration files with extension .god under the directory /etc/god/

* /etc/logrotate.d/god

  god writes logfile to /var/log/god.log.
  This recipe generages logrotation config file to rotate it on daily basis.

* /etc/init.d/god

  service script for SysV init

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/itamae-plugin-recipe-god. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Itamae::Plugin::Recipe::God project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/itamae-plugin-recipe-god/blob/master/CODE_OF_CONDUCT.md).
