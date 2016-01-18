# Vbuilder

Vbuilder is a project I started to dynamically create Vagrantfile configurations or simple skeleton Vagrantfiles, based on the given provider (virtualbox, vmware, aws, etc). Right now, since each vagrant provider can be configured in different ways, with different attributes, I'm stashing those attributes in a YAML file that gets loaded in when a valid provider is given. I also have custom templates for those providers that get injected into the 'master' Vagrantfile template. If there are defaults in the configurations, these will be the values in the generated template, unless the user chooses to interactively fill out the Vagrantfile in the CLI with interactive mode.

## TODO
- [x] Interactive vagrantfile building
- [x] aws provider
- [x] virtualbox provider
- [ ] vmware provider
- [ ] docker provider
- [ ] ability to load custom providers attributes via cli
- [ ] ability to load custom provider templates via cli


## Installation

install it yourself as:

    $ gem install vbuilder

## Usage

To list all currently available vagrant providers, run this:
```bash
$ vbuilder -P
     or
$ vbuilder --providers
```
** currently only 'aws' and 'virtualbox' are supported for Vagrantfile generation. More to come soon.

To generate a simple Vagrantfile based on a provider, granted that provider is valid, run this:
```bash
$ vbuilder --provider <some provider>
```

To generate a Vagrantfile interactively on the CLI, with a given provider, run this:
```bash
$ vbuilder -i --provider <some provider>
     or
$ vbuilder --interactive --provider <some provider>
```

...and of course, for the help menu, run this:
```bash
$ vbuilder --help
     or
$ vbuilder -h
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec/test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iandesj/vbuilder. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

