class Vbuilder
    class Generator
        class Options < Hash
            attr_accessor :opts, :orig_args

            def initialize(args)
                super()

                @orig_args = args.clone

                require 'optparse'
                @opts = OptionParser.new do |o|
                    o.banner = "Usage: #{File.basename($0)} [options]\ne.g. #{File.basename($0)} --provider aws"

                    o.on('-v', '--version', 'show ruby gem version') do |ver|
                        puts"Version: #{Vbuilder::Version.version}"
                        exit
                    end

                    o.on('-i', '--interactive', 'choose to interactively fill these config attributes out on the CLI') do
                        self[:interactive] = true
                    end

                    o.on('--provider [PROVIDER]', 'specify the provider to use in the building of your Vagrantfile') do |provider|
                        self[:provider] = provider
                    end

                    o.separator ""
                end

                begin
                    @opts.parse!(args)
                rescue OptionParser::InvalidOption => e
                    self[:invalid_argument] = e.message
                end

                def merge(other)
                    self.class.new(@orig_args + other.orig_args)
                end
            end
        end
    end
end
