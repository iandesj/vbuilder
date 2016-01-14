require 'shellwords'

class Vbuilder
    class Generator
        class Application
            class << self
                include Shellwords

                def run!(*arguments)
                    options = build_options(arguments)

                    if options[:invalid_argument]
                        $stderr.puts options[:invalid_argument]
                        options[:show_help] = true
                        return 1
                    end

                    if options[:show_version]
                        $stderr.puts "Version: #{Vbuilder::Version.version}"
                        return 1
                    end

                    if options[:show_help]
                        $stderr.puts options.opts
                        return 1
                    end

                    begin
                        generator = Vbuilder::Generator.new(options)
                        generator.run
                        return 0
                    end
                end

                def build_options(arguments)
                    env_opts_string = ENV['VBUILDER_OPTS'] || ""
                    env_opts        = Vbuilder::Generator::Options.new(shellwords(env_opts_string))
                    argument_opts   = Vbuilder::Generator::Options.new(arguments)

                    env_opts.merge(argument_opts)
                end
            end
        end
    end
end
