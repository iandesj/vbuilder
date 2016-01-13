require 'vbuilder/version'
require 'pathname'

class Vbuilder
    class Generator
        require 'vbuilder/generator/options'
        require 'vbuilder/generator/application'

        attr_accessor :options

        def initialize(options = {})
            self.options = options

            self.provider = options[:provider]
        end
    end
end
