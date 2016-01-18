require 'vbuilder/version'
require 'helper'
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
            provider_attrs = Vbuilder::Helper::Utility.get_provider_attrs(@provider)

            if @options[:interactive]
                provider_attrs = Vbuilder::Helper::Cli.start_cli(provider_attrs)
            end

            # create new provider based on provider attributes
            provider = Vbuilder::Generator::Provider.new(provider_attrs)

            # check provider dependencies before moving on
            # gem execution will exit if unmet
            provider.check_dependencies

            template_file = Vbuilder::Helper::Utility.get_template_file

            renderer = ERB.new(template_file).result(provider.get_binding)

            File.open('Vagrantfile', 'w+') do |f|
                f.write(renderer)
            end
        end
    end
end
