require 'vbuilder/version'
require 'pathname'

class Vbuilder
    class Generator
        require 'vbuilder/generator/options'
        require 'vbuilder/generator/application'

        attr_accessor :options, :provider

        def initialize(options = {})
            @options = options
            @provider = options[:provider]
        end

        def run
        end
    end
end
