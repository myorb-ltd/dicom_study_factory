# - PUBLIC -
# DicomStudyFactory
This is a `PUBLIC REPOSITORY` shared open source library.
Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/dicom_study_factory`. To experiment with that code, run `bin/console` for an interactive prompt.

## Ruby Version
2.6.1

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dicom_study_factory'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dicom_study_factory

## Usage

Clone the repo and them `bin/console` to use the library.
```ruby
# you can point the source_dir: 'to/your/dicoms/dir/path', by default is tmp/source_dir and
# output_dir: 'to the dir target' by default is tmp/ouptut
t = DicomStudyFactory::Transformer.new
t.fill_tags # will read and write new images in the output_dir with factored tags
t.write_csv # will write a file with the new studies tags
```
The transformer class will read all the images at first to group by patient and study all the dcm images.
Then the output dir will contain the new dicoms in a trree directorys group by PATIENT_NAME/STUDY_INSTANCE_UID ...
The write_csv method is to create a `studies.csv`file of the studies tags.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Test

It requires download a [FluoroDisplayShutter DICOM](http://www.dclunie.com/images/FluoroWithDisplayShutter.dcm.zip).
It will be downloaded the first time you run the test automatically.

Using Guard:
     $ guard

Or rspec:
     $ rspec


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dicom_study_factory. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DicomStudyFactory project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/dicom_study_factory/blob/master/CODE_OF_CONDUCT.md).
