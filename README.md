# HttpProfiler

HttpProfiler uses [curb](https://github.com/taf2/curb) and 
[floatstats](https://github.com/fizquierdo/floatstats) to compute 
connection time statistics for configurable collections of webserver 
urls.

## Installation

Add this line to your application's Gemfile:

    gem 'httpProfiler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install httpProfiler

## Usage

### Command line

For help type:

> httpProfiler --help

Invoking the example YAML configuration file:

> httpProfiler $HTTP_TIMER_GEM/examples/httpProfiler.yaml

### Library

> require 'httpProfiler'

> results = HttpProfiler.run(configFileName, configHash);
> results.each_pair do | requestGroupName, requestGroupResults |
>   puts "#{requestGroupName}, #{requestGroupResults.join(', ')}";
> end

The results is a Hash whose keys are the requestGroupNames taken from 
the configHash, and whose results are the curb derived connection time 
min, average, median, maximum and stardard deviations for all of the 
urls in each requestGroup.

See the $HTTP_TIMER_GEM/examples/httpProfiler.yaml file for documentation 
of the configuration options.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under the [MIT](http://opensource.org/licenses/MIT) license 
(see LICENSE.txt).
