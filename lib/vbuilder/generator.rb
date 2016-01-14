require 'vbuilder/version'
require 'pathname'
require 'yaml'
require 'erb'

class Vbuilder
    class Generator
        require 'vbuilder/generator/options'
        require 'vbuilder/generator/application'
        require 'vbuilder/generator/provider'

        attr_accessor :options, :provider

        def initialize(options = {})
            @options = options
            @provider = options[:provider]
        end

        def run
            # get provider attributes from correct yaml file
            provider_attrs = get_provider_attrs

            # create new provider based on provider attributes
            provider = Vbuilder::Generator::Provider.new(provider_attrs)

            # check provider dependencies before moving on
            provider.check_dependencies

            template_file = get_template_file

            renderer = ERB.new(template_file).result(provider.get_binding)

            File.open('Vagrantfile', 'w+') do |f|
                f.write(renderer)
            end
        end

        # Helper functions
        # TODO: Move these functions to lib/helpers.rb
        def get_provider_attrs
            begin
                attrs_file = "../generator/attributes/#{@provider}.yaml"
                attrs_file = File.expand_path(attrs_file, __FILE__)

                YAML.load(File.read(attrs_file))
            rescue
                puts "Provider not found. Vagrantfile will not be generated."
            end
        end

        def get_template_file
            template_file = "../templates/master.erb"
            template_file = File.expand_path(template_file, __FILE__)

            File.read(template_file)
        end
    end
end
