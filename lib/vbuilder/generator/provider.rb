class Vbuilder
    class Generator
        class Provider
            
            def initialize(hash)
                @vm_box = nil
                @ssh_username = nil
                hash.each do |name, value| 
                    instance_variable_set("@#{name}", value)
                end
            end

            def get_binding
                binding()
            end

            def render(provider)
                template_file = "../../templates/providers/#{@provider}.erb"
                file = File.expand_path(template_file, __FILE__)
                content = File.read(file)
                t = ERB.new(content)

                t.result(binding)
            end

            def check_dependencies
                installed = `vagrant plugin list`
                @dependencies.each do |dependency|
                    if !installed.include? dependency
                        puts "Unmet dependency"
                        puts "Missing plugin '#{dependency}'"
                        exit 1
                    end
                end
            end
        end
    end
end
