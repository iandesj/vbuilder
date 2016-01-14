require 'optparse'
require 'helper'

class Vbuilder
    class Generator
        class Options < Hash
            attr_accessor :opts, :orig_args

            def initialize(args)
                super()

                @orig_args = args.clone

                @opts = OptionParser.new do |o|
                    o.banner = "Usage: #{File.basename($0)} [options]\ne.g. #{File.basename($0)} --provider aws"

                    o.on('-v', '--version', 'show ruby gem version') do |ver|
                        puts "Version: #{Vbuilder::Version.version}"
                        exit
                    end

                    o.on('-P', '--providers', 'see the list of valid providers') do
                        puts "Valid providers:"
                        Vbuilder::Helper::Utility.get_provider_list.each do |provider|
                            puts "  - #{provider}"
                        end

                        exit
                    end

                    o.on('-i', '--interactive', 'choose to interactively fill these config attributes out on the CLI') do
                        self[:interactive] = true
                    end

                    o.on('-p', '--provider [PROVIDER]', 'specify the provider to use in the building of your Vagrantfile') do |provider|
                        unless provider.nil?
                            self[:provider] = provider
                        else
                            self[:invalid_argument] = "please specify a provider"
                        end
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
