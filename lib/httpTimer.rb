require "httpTimer/version"
require 'curb';
require 'floatstats';

module HttpTimer

  class Runner

    def initialize(configFileName, config)
      @configFileName = configFileName;
      @options = config;
      @cookies = Hash.new();
      if @options.has_key?('cookies') then
        @cookies = @options['cookies'];
        @options.delete('cookies');
      end
      @requestGroups = Hash.new();
      if @options.has_key?('requestGroups') then
        @requestGroups = @options['requestGroups'];
        @options.delete('requestGroups');
      end
    end

    def runRequestGroup(requestGroupName, requestGroup)
      requestList = Array.new();
      @options['replications'].times do 
        requestGroup['urls'].each do | url |
          requestList.push(url);
        end    
      end

      randGen = nil;
      if requestGroup['randomize'] == 0 then
      elsif requestGroup['randomize'] < 0 then
        randGen = Random.new();
      else
        randGen = Random.new(requestGroup['randomize']);
      end
      requestList.shuffle!(random: randGen) unless randGen.nil?;

      connectTimes = Array.new();

      puts requestGroupName if @options['verbose'];
      requestList.each do | url |
        puts "\t#{url}" if @options['verbose'];
        c = Curl::Easy.new(url);
        c.follow_location = true;
        c.perform;
        connectTimes.push(c.connect_time);
        if 0 < @options['delay'] then
          puts "\t\tsleeping(#{@options['delay']})" if @options['verbose'];
          sleep(@options['delay']);
        end
      end

      [ connectTimes.min, 
        connectTimes.average,
        connectTimes.median,
        connectTimes.max,
        connectTimes.standard_deviation ]
    end

    def run
      if @options['verbose'] then
        require 'pp';
        puts "\n\nConfiguration taken from: [#{@configFileName}]";
        puts "options:";
        pp @options;
        puts "requestGroups:";
        pp @requestGroups;
        puts "\n\n";
      end
      results = Hash.new();
      @requestGroups.each_pair do | requestGroupName, requestGroup |
        results[requestGroupName] = runRequestGroup(requestGroupName, 
                                                    requestGroup.merge!(@options));
      end
      results;
    end

  end

  def self.run(configFile, config)
    runner = HttpTimer::Runner.new(configFile, config);
    runner.run;
  end

end
