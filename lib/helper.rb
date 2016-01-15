require 'helper'
require 'highline'

class Vbuilder
    class Helper
        module Utility
            
            def self.get_provider_list
                attributes_dir = "../vbuilder/generator/attributes"
                attributes_dir = File.expand_path(attributes_dir, __FILE__)

                provider_files = Dir.entries(attributes_dir)
                provider_files = provider_files - ["..", "."]

                # return an array of all the providers
                provider_files.map { |item| item.gsub(".yaml", "") }
            end
            
            def self.get_provider_attrs(provider)
                begin
                    attrs_file = "../vbuilder/generator/attributes/#{provider}.yaml"
                    attrs_file = File.expand_path(attrs_file, __FILE__)

                    YAML.load(File.read(attrs_file))
                rescue
                    # rescue and print out cause
                    puts "Provider '#{provider}' not valid. Vagrantfile will not be generated."
                    puts "Valid providers:"
                    self.get_provider_list.each { |item| puts "  - #{item}" }
                    exit 1
                end
            end

            def self.get_template_file
                template_file = "../vbuilder/templates/master.erb"
                template_file = File.expand_path(template_file, __FILE__)

                File.read(template_file)
            end
        end

        module Cli

            # this method gets kicked off when the user chooses to interactively create it
            def self.start_cli(attributes)
                cli = HighLine.new
                attributes.each do |key, value|
                    if key != "meta"
                        case attributes[key]
                            when Array
                                attributes[key] = cli.ask("#{key} - (comma sep list) :", lambda { |val|val.split(/,\s*/)  })
                            when String
                                attributes[key] = cli.ask("#{key}: ")
                            when Fixnum
                                attributes[key] = cli.ask("#{key}: ", Integer)
                            when Float
                                attributes[key] = cli.ask("#{key}: ", Float)
                            else
                                puts attributes[key].class
                        end
                    end
                end

                attributes
            end
        end
    end
end
